local Metatable = getrawmetatable(game) 
local Namecall, Newindex, Index = Metatable.__namecall, Metatable.__newindex, Metatable.__index
local Caller, Closure = checkcaller or is_protosmasher_caller, newcclosure or function(f) return f end 

setreadonly(Metatable, false)

Metatable.__namecall = Closure(function(self, ...)
    local Args, Method = {...}, getnamecallmethod() or get_namecall_method();
    
    if Method == "FireServer" and self.Name == "MainEvent" then 
        return wait(9e9)
    end
    
    return Namecall(self, unpack(Args))
end)

setreadonly(Metatable, true)

do 
    local Client = game:GetService"Players".LocalPlayer
    
    function DestroyAc()
        for _, v in next, Client.Character:GetChildren() do 
            if v and v:IsA"Script" then
                for _, v2 in next, v:GetChildren() do 
                    if v2 and v2.Name == "LocalScript" then 
                        v:Destroy()
                    end
                end
            end
        end
    end
    DestroyAc()
    
    Client.CharacterAdded:Connect(function()
        Client.Character:WaitForChild"Humanoid";
        
        DestroyAc()
    end)
end
