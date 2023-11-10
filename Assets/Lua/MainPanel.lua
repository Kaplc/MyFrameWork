require("Assets.Lua.RolePanel")

MainPanel = BasePanel:SubClass("MainPanel")

MainPanel.btnRole = nil

function MainPanel.Init(self)
    -- 获取button脚本
    self.btnRole = self:GetControl("ButtonRole", "Button")
    -- 添加事件
    self.btnRole.onClick:AddListener(function()
        RolePanel:Show()
    end)
    self.isInit = true
end 

-- 重写show方法
function MainPanel.Show(self)

    if self.isInit == false then
        -- 知道资源名直接加载
        self.base:Show("MainPanel")
        self:Init()
    end
    
    self.panelObj:SetActive(true)
end 