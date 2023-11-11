RolePanel = BasePanel:SubClass('RolePanel')

RolePanel.btnBack = nil
RolePanel.tgWeapon = nil
RolePanel.tgItem = nil
RolePanel.tgStone = nil
RolePanel.content = nil

function RolePanel.Init(self)
    --
    self.btnBack = self:GetControl('ButtonBack', 'Button')
    self.tgItem = self:GetControl('ToggleItem', 'Toggle')
    self.tgWeapon = self:GetControl('ToggleWeapon', 'Toggle')
    self.tgStone = self:GetControl('ToggleStone', 'Toggle')

    -- 获取scrollView的content
    self.content = GameObject.Find('Content')

    -- 控件添加事件
    self.btnBack.onClick:AddListener(
        function()
            RolePanel:Hide()
        end
    )

    self.tgWeapon.onValueChanged:AddListener(
        function(isOn)

            if isOn == false then
                return
            end

            -- 每次点击先清空
            RolePanel:ClearContent()
            
            -- 无数据跳过
            if DataManger.weaponInfoDic == nil then
                return
            end
            
            -- 计数第几个格子
            local i = 0 -- 总数
            local j = 0 -- 单行数量
            -- 遍历数据字典
            for key, value in pairs(DataManger.weaponInfoDic) do
                local res = string.split(value.abPath, "/")
                -- 实例化格子预设体
                local cell = ABManager.Instance:Load(res[1], "ImageCell", typeof(GameObject))
                cell.transform:SetParent(RolePanel.content.transform, false)

                -- 设置位置
                local rectTransform = cell:GetComponent(typeof(RectTransform))
                -- () 为实例化
                local v2 = Vector2(20 + (140 * j), -12 - (150 * i % 5))
                rectTransform.anchoredPosition = v2
                
                -- 获取cell的控件
                local txCount = cell.transform:Find("TextCount"):GetComponent(typeof(Text))
                local imgIcon = cell.transform:Find("ImageIcon"):GetComponent(typeof(Image))

                txCount.text = tostring(value.count)
                imgIcon.sprite = ABManager.Instance:Load(res[1], res[2], typeof(Sprite))
                
                i = i + 1
                j = j + 1

                if j > 3 then
                    j = 0
                end
            end
            
        end
    )
    self.tgItem.onValueChanged:AddListener(
        function(isOn)
            if isOn == false then
                return
            end

            -- 每次点击先清空
            RolePanel:ClearContent()
            
            -- 无数据跳过
            if DataManger.itemInfoDic == nil then
                return
            end
            
            -- 计数第几个格子
            local i = 0 -- 总数
            local j = 0 -- 单行数量
            -- 遍历数据字典
            for key, value in pairs(DataManger.itemInfoDic) do
                local res = string.split(value.abPath, "/")
                -- 实例化格子预设体
                local cell = ABManager.Instance:Load(res[1], "ImageCell", typeof(GameObject))
                cell.transform:SetParent(RolePanel.content.transform, false)

                -- 设置位置
                local rectTransform = cell:GetComponent(typeof(RectTransform))
                -- () 为实例化
                local v2 = Vector2(20 + (140 * j), -12 - (150 * i % 5))
                rectTransform.anchoredPosition = v2
                
                -- 获取cell的控件
                local txCount = cell.transform:Find("TextCount"):GetComponent(typeof(Text))
                local imgIcon = cell.transform:Find("ImageIcon"):GetComponent(typeof(Image))

                txCount.text = tostring(value.count)
                imgIcon.sprite = ABManager.Instance:Load(res[1], res[2], typeof(Sprite))
                
                i = i + 1
                j = j + 1

                if j > 3 then
                    j = 0
                end
            end


        end
    )
    self.tgStone.onValueChanged:AddListener(
        function(isOn)
            if isOn == false then
                return
            end
            
            -- 每次点击先清空
            RolePanel:ClearContent()
            
            -- 无数据跳过
            if DataManger.stoneInfoDic == nil then
                return
            end
            
            -- 计数第几个格子
            local i = 0 -- 总数
            local j = 0 -- 单行数量
            -- 遍历数据字典
            for key, value in pairs(DataManger.stoneInfoDic) do
                local res = string.split(value.abPath, "/")
                -- 实例化格子预设体
                local cell = ABManager.Instance:Load(res[1], "ImageCell", typeof(GameObject))
                cell.transform:SetParent(RolePanel.content.transform, false)

                -- 设置位置
                local rectTransform = cell:GetComponent(typeof(RectTransform))
                -- () 为实例化
                local v2 = Vector2(20 + (140 * j), -12 - (150 * i % 5))
                rectTransform.anchoredPosition = v2
                
                -- 获取cell的控件
                local txCount = cell.transform:Find("TextCount"):GetComponent(typeof(Text))
                local imgIcon = cell.transform:Find("ImageIcon"):GetComponent(typeof(Image))

                txCount.text = tostring(value.count)
                imgIcon.sprite = ABManager.Instance:Load(res[1], res[2], typeof(Sprite))
                
                i = i + 1
                j = j + 1

                if j > 3 then
                    j = 0
                end
            end


        end
    )

    -- 默认选中武器
    self.tgWeapon.isOn = ture

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

-- 清空content
function RolePanel.ClearContent(self)
    local cells = self.content.transform:GetComponentsInChildren(typeof(Transform))

    -- 自身总是第一个
    for i = 1, cells.Length - 1 do
        print(cells[i].name)
        Destroy(cells[i].gameObject)
    end
end


