local OriginalEWAPI = EWAPI

function EWAPI()
    local api = OriginalEWAPI()

    api.OpenNotepad = function(path)
        if not path or path == "" then
            return
        end

        -- Windows path -> URL path
        path = path:gsub("\\", "/")

        -- UTF-8 URL encode
        path = path:gsub("([^%w%-%._~/])", function(c)
            local result = ""

            for i = 1, #c do
                result = result .. string.format("%%%02X", string.byte(c, i))
            end

            return result
        end)

        api.LaunchURL("hng://notepad/" .. path)
    end

    return api
end
-- /run EWAPI().OpenNotepad("D:\\Byster\\Interface\\AddOns\\_GM[AdminskieUtehi3]\\Шмотки\\Шмотки на мм ханта.txt")
-- /run EWAPI().OpenNotepad([[D:\Byster\Interface\AddOns\_GM[AdminskieUtehi3]\Шмотки\Шмотки на мм ханта.txt]])
