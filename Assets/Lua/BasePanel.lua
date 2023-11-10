BasePanel = Object:SubClass('BasePanel')

-- 面板名称
BasePanel.name = nil
-- 面板对象
BasePanel.panelObj = nil
-- 控件字典
BasePanel.controlsDic = {}
-- 初始化标识
BasePanel.isInit = false

-- 初始化函数
function BasePanel.Init(self, resName)
    -- ab包加载预设体
    self.panelObj = ABManager.Instance:Load('ui', resName, typeof(GameObject))
    local canvas = GameObject.Find('Canvas')
    self.panelObj.transform:SetParent(canvas.transform, false)

    self.name = resName

    -- 查找该 panel下的所有控件
    self:FindControls()
end

function BasePanel.Show(self, resName)
    -- 初始化一次
    if self.isInit == false then
        self:Init(resName)
    end

    self.panelObj:SetActive(true)
end

function BasePanel.Hide(self)
    -- 失活隐藏
    self.panelObj:SetActive(false)
end

-- 获取所有控件
function BasePanel.FindControls(self)
    -- 获取所有 Button
    local buttons = self.panelObj:GetComponentsInChildren(typeof(Button))
    for i = 0, buttons.Length - 1 do
        -- 获取对象名
        local key = buttons[i].gameObject.name

        -- 第一次创建该对象存放所有控件的表
        if self.controlsDic[key] == nil then
            self.controlsDic[key] = {}
        end

        -- 对象表中根据控件类型放入控件脚本
        self.controlsDic[key]['Button'] = buttons[i]
    end

    -- 获取 Text
    local texts = self.panelObj:GetComponentsInChildren(typeof(Text))
    for i = 0, texts.Length - 1 do
        local key = texts[i].gameObject.name

        if self.controlsDic[key] == nil then
            self.controlsDic[key] = {}
        end

        self.controlsDic[key]['Text'] = texts[i]
    end

    -- 获取 Toggle
    local toggles = self.panelObj:GetComponentsInChildren(typeof(Toggle))
    for i = 0, toggles.Length - 1 do
        local key = toggles[i].gameObject.name

        if self.controlsDic[key] == nil then
            self.controlsDic[key] = {}
        end

        self.controlsDic[key]['Toggle'] = toggles[i]
    end

    -- 获取 Image
    local images = self.panelObj:GetComponentsInChildren(typeof(Image))
    for i = 0, images.Length - 1 do
        local key = images[i].gameObject.name

        if self.controlsDic[key] == nil then
            self.controlsDic[key] = {}
        end

        self.controlsDic[key]['Image'] = images[i]
    end

    -- 获取 ScrollRect
    local scrollRects = self.panelObj:GetComponentsInChildren(typeof(ScrollRect))
    for i = 0, scrollRects.Length - 1 do
        local key = scrollRects[i].gameObject.name

        if self.controlsDic[key] == nil then
            self.controlsDic[key] = {}
        end

        self.controlsDic[key]['ScrollRect'] = scrollRects[i]
    end
end

-- 通过对象名和控件类型获取控件
function BasePanel.GetControl(self, objName, controlType)
    if self.controlsDic[objName] ~= nil then
        if self.controlsDic[objName][controlType] ~= nil then
            return self.controlsDic[objName][controlType]
        end
    end

    return nil
end
