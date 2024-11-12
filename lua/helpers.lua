local M = {}

function M.parse_git_diff(input, stderr)
  local stderr_count = 0
  for _ in pairs(stderr) do
    stderr_count = stderr_count + 1
  end
  if stderr_count > 0 then
    return stderr
  end

  local meta, hunks = {}, {}
  local currentHunk

  for _, l in ipairs(input) do
    if l:find("^@@") then
      if currentHunk ~= nil then
        table.insert(hunks, currentHunk)
      end
      currentHunk = { lines = {} }
      currentHunk.start_line = l
      local fromrange, torange = l:match("^@@ %-(%d+[,%d]*) %+(%d+[,%d]*) @@")
      local fline, fnumb = fromrange:match("([^,]*),?([^,]*)")
      if not fnumb or fnumb == "" or fnumb == "0" then
        fnumb = "1"
      end
      local tline, tnumb = torange:match("([^,]*),?([^,]*)")
      if not tnumb or tnumb == "" or tnumb == "0" then
        tnumb = "1"
      end
      currentHunk.fromrange = fromrange
      currentHunk.torange = torange
      currentHunk.fline = fline
      currentHunk.fnumb = fnumb
      currentHunk.tline = tline
      currentHunk.tnumb = tnumb
      currentHunk.torange = torange
      currentHunk.from_start = tonumber(fline)
      currentHunk.from_end = tonumber(fline) + tonumber(fnumb) - 1
      currentHunk.to_start = tonumber(tline)
      currentHunk.to_end = tonumber(tline) + tonumber(tnumb) - 1
    elseif currentHunk ~= nil then
      table.insert(currentHunk.lines, l)
    end
  end
  if currentHunk ~= nil then
    table.insert(hunks, currentHunk)
  end

  return hunks, meta
end

function M.find_hunk(hunks, linenr)
  for _, hunk in ipairs(hunks) do
    if linenr >= hunk.to_start and linenr <= hunk.to_end then
      return hunk
    end
  end
  return nil
end

return M
