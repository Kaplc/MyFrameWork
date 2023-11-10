RolePanel = BasePanel:SubClass('RolePanel')

RolePanel.btnBack = nil

function RolePanel.Init(self)
    self.btnBack = self:GetControl('ButtonBack', 'Button')
    self.btnBack.onClick:AddListener(
        function()
            RolePanel:Hide()
        end
    )

    self.isInit = true
end

function RolePanel.Show(self)
    if self.isInit == false then
        -- 知道资源名直接加载
        self.base:Show('RolePanel')
        self:Init()
    end

    self.panelObj:SetActive(true)
end
