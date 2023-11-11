DataManger = Object:SubClass("DataManger")

DataManger.weaponInfoDic = BinaryManager.Instance:LoadExcelBinary(typeof(WeaponInfo), typeof(WeaponInfoContainer)).WeaponInfoDic
DataManger.itemInfoDic = BinaryManager.Instance:LoadExcelBinary(typeof(ItemInfo), typeof(ItemInfoContainer)).ItemInfoDic
DataManger.stoneInfoDic = BinaryManager.Instance:LoadExcelBinary(typeof(StoneInfo), typeof(StoneInfoContainer)).StoneInfoDic