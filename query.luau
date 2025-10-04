local API = "https://raw.githubusercontent.com/thecreare/wos-remote-config/refs/heads/main/"
local NAMESPACE = "__creare-remote-config:"

return function(modem: Modem, disk: Disk)
    assert(typeof(modem) == "table" and modem.ClassName == "Modem", "Can't initialize without Modem")
    assert(typeof(disk) == "table" and disk.ClassName == "Disk", "Can't initialize without Disk")

    return function(path: string): (string | {[any]: any})?
        -- Fetch latest version
        local ok, response = pcall(modem.RequestAsync, modem, {
            Url = API .. path,
            Method = "GET",
        })

        local disk_key = NAMESPACE .. path

        local text

        if ok and response.Success then
            text = response.Body
            disk:Write(disk_key, text)
        else
            local error_message = if ok then `"{response.StatusMessage}" ({response.StatusCode})` else `"{response}"`
            warn(`Failed to fetch latest config with error {error_message}, returning cached version`)
            text = disk:Read(disk_key)
        end

        -- Attempt to decode the response as json
        local ok, json = pcall(JSONDecode, text)
        if ok then
            return json
        end

        return text
    end
end
