--local flagaddress = 
--{[0xB7FF] through [0XB85F]}

local flagletters = 
{
[0x20] = {""}, --Space?
[0x21] = {"!"},
[0x3F] = {"?"},
[0x41] = {"A"},
[0x44] = {"D"},
[0x45] = {"E"},
[0x47] = {"G"},
[0x48] = {"H"},
[0x4D] = {"M"},
[0x4E] = {"N"},
[0x51] = {"Q"},
[0x52] = {"R"},
[0x57] = {"W"},
[0x61] = {"a"},
[0x62] = {"b"},
[0x63] = {"c"},
[0x64] = {"d"},
[0x65] = {"e"},
[0x66] = {"f"},
[0x67] = {"g"},
[0x68] = {"h"},
[0x69] = {"i"},
[0x6D] = {"m"},
[0x6E] = {"n"},
[0x6F] = {"o"},
[0x72] = {"r"},
[0x73] = {"s"},
[0x74] = {"t"},
[0x75] = {"u"},
[0x77] = {"w"},
[0x78] = {"x"},
[0x7A] = {"z"}
}

function removeQuestionAndExclamation(str)
    return str:gsub("[!?]", "")
end

local inputString = "GfnsHt?cMet?gNbwRot?sVmWeg?tu"
local outputString = removeQuestionAndExclamation(inputString)
print(outputString) -- Output: "GfnsHtcMetgNbwRotsVmWegtu"


function splitStringByUpperCase(str)
    local parts = {}
    local currentPart = ""
    
    for i = 1, #str do
        local char = str:sub(i, i)
        if char:match("%u") then
            table.insert(parts, currentPart)
            currentPart = char
        else
            currentPart = currentPart .. char
        end
    end
    
    table.insert(parts, currentPart)
    
    return parts
end

local inputString = "GfnsHtcMetgNbwRotsVmWegtu"
local parts = splitStringByUpperCase(inputString)

for i, part in ipairs(parts) do
    print(i, part)
end
