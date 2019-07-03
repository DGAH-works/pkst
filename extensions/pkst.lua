--[[
	太阳神三国杀武将扩展包·单挑测试
	适用版本：V2 - 愚人版（版本号：20150401）清明补丁（版本号：20150405）
	武将总数：12
	武将一览：
		1、四限英姿（英姿）
		2、三限英闭（英姿、闭月）
		3、稳定一杀（杀使）
		4、一起神云（绝境、龙魂）
		5、觉醒策（激昂、英姿、英魂）
		6、觉醒钟会（权计、自立、排异）
		7、觉醒邓艾（屯田、急袭）
		8、觉醒姜维（挑衅、志继、观星）
		9、觉醒神司马（忍戒、极略）
		10、原版神司马（忍戒、拜印、连破）＋（极略）
		11、自修孙坚（自修）
		12、变限白板
	所需标记：
		1、@pkZiLiMark（“自立”标记，来自技能“自立”）
		2、@pkZhiJiMark（“志继”标记，来自技能“志继”）
]]--
module("extensions.pkst", package.seeall)
extension = sgs.Package("pkst", sgs.Package_GeneralPack)
--测试参数
JueXingCe_MaxHp = 3 --觉醒策的体力上限
JueXingCe_StartHp = 999 --觉醒策的初始体力值
BianXianBaiBan_MaxHp = 20 --变限白板的体力上限
--翻译信息
sgs.LoadTranslationTable{
	["pkst"] = "单挑测试",
}
--[[****************************************************************
	编号：PK - 001
	武将：四限英姿
	称号：测试员
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
SiXianYingZi = sgs.General(extension, "pkSiXianYingZi", "god", 4, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkSiXianYingZi"] = "四限英姿",
	["&pkSiXianYingZi"] = "四英",
	["#pkSiXianYingZi"] = "测试员",
	["designer:pkSiXianYingZi"] = "网络",
	["cv:pkSiXianYingZi"] = "官方",
	["illustrator:pkSiXianYingZi"] = "无",
	["~pkSiXianYingZi"] = "四限英姿 的阵亡台词",
}
--[[
	技能：英姿
	描述：摸牌阶段，你可以额外摸一张牌。
]]--
YingZiX = sgs.CreateTriggerSkill{
	name = "pkYingZiX",
	frequency = sgs.Skill_Frequent,
	events = {sgs.DrawNCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if room:askForSkillInvoke(player, "pkYingZiX", data) then
			room:broadcastSkillInvoke("pkYingZiX") --播放配音
			room:notifySkillInvoked(player, "pkYingZiX") --显示技能发动
			local count = data:toInt() + 1
			data:setValue(count)
		end
		return false
	end,
}
--添加技能
--SiXianYingZi:addSkill("nosyingzi")
SiXianYingZi:addSkill(YingZiX)
--翻译信息
sgs.LoadTranslationTable{
	["pkYingZiX"] = "英姿",
	[":pkYingZiX"] = "摸牌阶段，你可以额外摸一张牌。",
	["$pkYingZiX1"] = "哈！哈哈哈哈……",
	["$pkYingZiX2"] = "汝等看好了！……",
}
--[[****************************************************************
	编号：PK - 002
	武将：三限英闭
	称号：测试员
	势力：神
	性别：男
	体力上限：3勾玉
]]--****************************************************************
SanXianYingBi = sgs.General(extension, "pkSanXianYingBi", "god", 3, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkSanXianYingBi"] = "三限英闭",
	["&pkSanXianYingBi"] = "英闭",
	["#pkSanXianYingBi"] = "测试员",
	["designer:pkSanXianYingBi"] = "网络",
	["cv:pkSanXianYingBi"] = "官方",
	["illustrator:pkSanXianYingBi"] = "官方合成",
	["~pkSanXianYingBi"] = "三限英闭 的阵亡台词",
}
--[[
	技能：英姿
	描述：摸牌阶段，你可以额外摸一张牌。
]]--
--添加技能
--SanXianYingBi:addSkill("nosyingzi")
SanXianYingBi:addSkill("pkYingZiX")
--[[
	技能：闭月
	描述：回合结束阶段开始时，你可以摸一张牌。
]]--
--添加技能
SanXianYingBi:addSkill("biyue")
--[[****************************************************************
	编号：PK - 003
	武将：稳定一杀
	称号：测试员
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
WenDingYiSha = sgs.General(extension, "pkWenDingYiSha", "god", 4, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkWenDingYiSha"] = "稳定一杀",
	["&pkWenDingYiSha"] = "稳定一杀",
	["#pkWenDingYiSha"] = "测试员",
	["designer:pkWenDingYiSha"] = "网络",
	["cv:pkWenDingYiSha"] = "无",
	["illustrator:pkWenDingYiSha"] = "KayaK",
	["~pkWenDingYiSha"] = "稳定一杀 的阵亡台词",
}
--[[
	技能：杀使（阶段技）
	描述：出牌阶段，若你未使用过【杀】：你可以将一张牌当做【杀】使用；若你没有牌，你可以视为使用一张【杀】。
		锁定技，你以此法使用的【杀】无距离限制。
]]--
ShaShiVS = sgs.CreateViewAsSkill{
	name = "pkShaShi",
	n = 1,
	view_filter = function(self, selected, to_select)
		return true
	end,
	view_as = function(self, cards)
		if #cards == 0 then
			if sgs.Self:isNude() then
				local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
				slash:setSkillName("pkShaShi")
				return slash
			end
		elseif #cards == 1 then
			local card = cards[1]
			local suit = card:getSuit()
			local point = card:getNumber()
			local slash = sgs.Sanguosha:cloneCard("slash", suit, point)
			slash:setSkillName("pkShaShi")
			slash:addSubcard(card)
			return slash
		end
	end,
	enabled_at_play = function(self, player)
		if player:hasFlag("pkShaShiInvoked") then
			return false
		elseif sgs.Slash_IsAvailable(player) then
			if player:getPhase() == sgs.Player_Play then
				return player:getSlashCount() == 0
			end
		end
		return false
	end,
}
ShaShi = sgs.CreateTriggerSkill{
	name = "pkShaShi",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardUsed, sgs.EventPhaseStart},
	view_as_skill = ShaShiVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardUsed then
			local use = data:toCardUse()
			local source = use.from
			if source and source:objectName() == player:objectName() then
				local slash = use.card
				if slash:getSkillName() == "pkShaShi" then
					room:setPlayerFlag(player, "pkShaShiInvoked")
				end
			end
		elseif event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Play then
				room:setPlayerFlag(player, "-pkShaShiInvoked")
			end
		end
		return false
	end,
}
ShaShiMod = sgs.CreateTargetModSkill{
	name = "#pkShaShiMod",
	distance_limit_func = function(self, player, card)
		if card:getSkillName() == "pkShaShi" then
			return 1000
		end
		return 0
	end,
}
extension:insertRelatedSkills("pkShaShi", "#pkShaShiMod")
--添加技能
WenDingYiSha:addSkill(ShaShi)
WenDingYiSha:addSkill(ShaShiMod)
--翻译信息
sgs.LoadTranslationTable{
	["pkShaShi"] = "杀使",
	[":pkShaShi"] = "<font color=\"green\"><b>阶段技</b></font>，出牌阶段，若你未使用过【杀】：你可以将一张牌当做【杀】使用；若你没有牌，你可以视为使用一张【杀】。<font color=\"blue\"><b>锁定技</b></font>，你以此法使用的【杀】无距离限制。",
	["$pkShaShi"] = "技能 杀使 的台词",
}
--[[****************************************************************
	编号：PK - 004
	武将：一起神云
	称号：神威如龙
	势力：神
	性别：男
	体力上限：2勾玉
]]--****************************************************************
YiQiShenYun = sgs.General(extension, "pkYiQiShenYun", "god", 2, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkYiQiShenYun"] = "一起神云",
	["&pkYiQiShenYun"] = "赵云",
	["#pkYiQiShenYun"] = "神威如龙",
	["designer:pkYiQiShenYun"] = "网络",
	["cv:pkYiQiShenYun"] = "猎狐",
	["illustrator:pkYiQiShenYun"] = "KayaK",
	["~pkYiQiShenYun"] = "血染鳞甲，龙坠九天……",
}
--[[
	效果：分发起始手牌时，你将体力值重置为1。
]]--
YiQiShenYunEffect = sgs.CreateTriggerSkill{
	name = "#pkYiQiShenYunEffect",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DrawInitialCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		room:setPlayerProperty(player, "hp", sgs.QVariant(1))
		room:handleAcquireDetachSkills(player, "-#pkYiQiShenYunEffect")
		return false
	end,
}
--添加效果
YiQiShenYun:addSkill(YiQiShenYunEffect)
--[[
	技能：绝境（锁定技）
	描述：摸牌阶段，你额外摸X张牌（X为你已损失的体力）；你的手牌上限+2。
]]--
--添加技能
YiQiShenYun:addSkill("juejing")
YiQiShenYun:addSkill("#juejing-draw")
--[[
	技能：龙魂
	描述：你可以将X张黑桃/红心/草花/方块牌当做【无懈可击】/【桃】/【闪】/火【杀】使用或打出。（X为你的体力且至少为1）
]]--
--添加技能
YiQiShenYun:addSkill("longhun")
--[[****************************************************************
	编号：PK - 005
	武将：觉醒策
	称号：江东的小霸王
	势力：吴
	性别：男
	体力上限：3勾玉
]]--****************************************************************
JueXingCe = sgs.General(extension, "pkJueXingCe", "wu", JueXingCe_MaxHp, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkJueXingCe"] = "觉醒策",
	["&pkJueXingCe"] = "孙策",
	["#pkJueXingCe"] = "江东的小霸王",
	["designer:pkJueXingCe"] = "网络",
	["cv:pkJueXingCe"] = "猎狐",
	["illustrator:pkJueXingCe"] = "KayaK",
	["~pkJueXingCe"] = "内事不决问张昭，外事不决问周瑜……",
}
--[[
	效果：分发起始手牌时，你将体力值重置为既定值。
]]--
JueXingCeEffect = sgs.CreateTriggerSkill{
	name = "#pkJueXingCeEffect",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DrawInitialCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local maxhp = player:getMaxHp()
		local x = math.min(maxhp, JueXingCe_StartHp)
		room:setPlayerProperty(player, "hp", sgs.QVariant(x))
		room:handleAcquireDetachSkills(player, "-#JueXingCeEffect")
		return false
	end,
}
--添加效果
JueXingCe:addSkill(JueXingCeEffect)
--[[
	技能：激昂
	描述：每当你使用一张【决斗】或红色的【杀】时，你可以摸一张牌；每当你成为一张【决斗】或红色【杀】的目标时，你可以摸一张牌。
]]--
JiAng = sgs.CreateTriggerSkill{
	name = "pkJiAng",
	frequency = sgs.Skill_Frequent,
	events = {sgs.CardUsed, sgs.TargetConfirming},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		local card = use.card
		local can_invoke = false
		if card:isKindOf("Duel") then
			can_invoke = true
		elseif card:isKindOf("Slash") and card:isRed() then
			can_invoke = true
		end
		if can_invoke then
			can_invoke = false
			if event == sgs.CardUsed then
				local source = use.from
				if source and source:objectName() == player:objectName() then
					can_invoke = true
				end
			elseif event == sgs.TargetConfirming then
				local targets = use.to
				for _,p in sgs.qlist(targets) do
					if p:objectName() == player:objectName() then
						can_invoke = true
						break
					end
				end
			end
			if can_invoke then
				if player:askForSkillInvoke("pkJiAng", data) then
					room:broadcastSkillInvoke("pkJiAng") --播放配音
					room:notifySkillInvoked(player, "pkJiAng") --显示技能发动
					room:drawCards(player, 1, "pkJiAng") 
				end
			end
		end
		return false
	end,
}
--添加技能
JueXingCe:addSkill(JiAng)
--JueXingCe:addSkill("jiang")
--翻译信息
sgs.LoadTranslationTable{
	["pkJiAng"] = "激昂",
	[":pkJiAng"] = "每当你使用一张【决斗】或红色的【杀】时，你可以摸一张牌；每当你成为一张【决斗】或红色【杀】的目标时，你可以摸一张牌。",
	["$pkJiAng1"] = "所向皆破，敌莫敢当！",
	["$pkJiAng2"] = "众将听令，直讨敌酋！",
}
--[[
	技能：英姿
	描述：摸牌阶段，你可以额外摸一张牌。
]]--
YingZi = sgs.CreateTriggerSkill{
	name = "pkYingZi",
	frequency = sgs.Skill_Frequent,
	events = {sgs.DrawNCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if room:askForSkillInvoke(player, "pkYingZi", data) then
			room:broadcastSkillInvoke("pkYingZi") --播放配音
			room:notifySkillInvoked(player, "pkYingZi") --显示技能发动
			local count = data:toInt() + 1
			data:setValue(count)
		end
		return false
	end,
}
--添加技能
--JueXingCe:addSkill("nosyingzi")
JueXingCe:addSkill(YingZi)
--翻译信息
sgs.LoadTranslationTable{
	["pkYingZi"] = "英姿",
	[":pkYingZi"] = "摸牌阶段，你可以额外摸一张牌。",
	["$pkYingZi"] = "雄武江东，威行天下！",
}
--[[
	技能：英魂
	描述：准备阶段开始时，若你已受伤，你可以指定一名其他角色并选择一项：1、令该角色摸X张牌，然后弃1张牌；2、令该角色摸1张牌，然后弃X张牌。（X为你已损失的体力）
]]--
function doYingHun(room, target, draw, discard)
	if draw > 0 then
		room:drawCards(target, draw, "pkYingHun")
	end
	if discard > 0 then
		local count = target:getCardCount(true)
		if discard < count then
			room:askForDiscard(target, "pkYingHun", discard, discard, false, true)
		elseif discard > 0 then
			target:throwAllHandCardsAndEquips()
		end
	end
end
YingHun = sgs.CreateTriggerSkill{
	name = "pkYingHun",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_Start then
			if player:isWounded() then
				local room = player:getRoom()
				local others = room:getOtherPlayers(player)
				local target = room:askForPlayerChosen(player, others, "pkYingHun", "yinghun-invoke", true, true)
				if target then
					local x = player:getLostHp()
					if x == 1 then
						room:broadcastSkillInvoke("pkYingHun", 1) --播放配音
						doYingHun(room, target, 1, 1)
					else
						local ai_data = sgs.QVariant()
						ai_data:setValue(target)
						player:setTag("pkYingHunTarget", ai_data) --For AI
						local choice = room:askForChoice(player, "pkYingHun", "d1tx+dxt1", ai_data)
						player:removeTag("pkYingHunTarget") --For AI
						if choice == "d1tx" then
							room:broadcastSkillInvoke("pkYingHun", 2) --播放配音
							doYingHun(room, target, 1, x)
						elseif choice == "dxt1" then
							room:broadcastSkillInvoke("pkYingHun", 1) --播放配音
							doYingHun(room, target, x, 1)
						end
					end
				end
			end
		end
		return false
	end,
}
--添加技能
--JueXingCe:addSkill("yinghun")
JueXingCe:addSkill(YingHun)
--翻译信息
sgs.LoadTranslationTable{
	["pkYingHun"] = "英魂",
	[":pkYingHun"] = "准备阶段开始时，若你已受伤，你可以指定一名其他角色并选择一项：1、令该角色摸X张牌，然后弃1张牌；2、令该角色摸1张牌，然后弃X张牌。（X为你已损失的体力）",
	["$pkYingHun1"] = "继吾父英魂，成江东大业！",
	["$pkYingHun2"] = "小霸王在此，匹夫受死！",
}
--[[****************************************************************
	编号：PK - 006
	武将：觉醒钟会
	称号：桀骜的野心家
	势力：魏
	性别：男
	体力上限：3勾玉
]]--****************************************************************
JueXingZhongHui = sgs.General(extension, "pkJueXingZhongHui", "wei", 3, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkJueXingZhongHui"] = "觉醒钟会",
	["&pkJueXingZhongHui"] = "钟会",
	["#pkJueXingZhongHui"] = "桀骜的野心家",
	["designer:pkJueXingZhongHui"] = "网络",
	["cv:pkJueXingZhongHui"] = "风叹息",
	["illustrator:pkJueXingZhongHui"] = "雪君S",
	["~pkJueXingZhongHui"] = "大权在手竟一夕败亡，时耶？命耶？……",
}
--[[
	效果：分发起始手牌时，你将牌堆顶的三张牌作为“权”置于你的武将牌上。
]]--
JueXingZhongHuiEffect = sgs.CreateTriggerSkill{
	name = "#pkJueXingZhongHuiEffect",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DrawInitialCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local ids = room:getNCards(3)
		player:addToPile("power", ids)
		room:handleAcquireDetachSkills(player, "-#JueXingZhongHuiEffect")
		return false
	end,
}
--添加效果
JueXingZhongHui:addSkill(JueXingZhongHuiEffect)
--[[
	技能：权计
	描述：每当你受到1点伤害后，你可以摸一张牌，然后将一张手牌置于武将牌上，称为“权”。每有一张“权”，你的手牌上限+1。 
]]--
--添加技能
JueXingZhongHui:addSkill("quanji")
--[[
	技能：自立（限定技）
	描述：准备阶段开始时，若“权”的数目不少于3，你可以选择一项：回复1点体力，或摸两张牌。
]]--
ZiLi = sgs.CreateTriggerSkill{
	name = "pkZiLi",
	frequency = sgs.Skill_Limited,
	events = {sgs.EventPhaseStart},
	limit_mark = "@pkZiLiMark",
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_Start then
			local pile = player:getPile("power")
			if pile:length() >= 3 then
				if player:askForSkillInvoke("pkZiLi", data) then
					local room = player:getRoom()
					room:broadcastSkillInvoke("pkZiLi") --播放配音
					room:notifySkillInvoked(player, "pkZiLi")
					player:loseMark("@pkZiLiMark", 1)
					local choice = "draw"
					if player:getLostHp() > 0 then
						choice = room:askForChoice(player, "zili", "recover+draw", data)
					end
					if choice == "recover" then
						local recover = sgs.RecoverStruct()
						recover.who = player
						recover.recover = 1
						room:recover(player, recover)
					elseif choice == "draw" then
						room:drawCards(player, 2, "pkZiLi")
					end
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		if target and target:isAlive() then
			if target:hasSkill("pkZiLi") then
				return target:getMark("@pkZiLiMark") > 0
			end
		end
		return false
	end,
}
--添加技能
JueXingZhongHui:addSkill(ZiLi)
--翻译信息
sgs.LoadTranslationTable{
	["pkZiLi"] = "自立",
	[":pkZiLi"] = "<font color=\"red\"><b>限定技</b></font>，准备阶段开始时，若“权”的数目不少于3，你可以选择一项：回复1点体力，或摸两张牌。",
	["$pkZiLi"] = "以我之才，何必屈人之下？",
	["@pkZiLiMark"] = "自立",
}
--[[
	技能：排异（阶段技）
	描述：你可以将一张“权”置入弃牌堆并选择一名角色：若如此做，该角色摸两张牌：若其手牌多于你，该角色受到1点伤害。
]]--
--添加技能
JueXingZhongHui:addSkill("paiyi")
--[[****************************************************************
	编号：PK - 007
	武将：觉醒邓艾
	称号：矫然的壮士
	势力：魏
	性别：男
	体力上限：3勾玉
]]--****************************************************************
JueXingDengAi = sgs.General(extension, "pkJueXingDengAi", "wei", 3, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkJueXingDengAi"] = "觉醒邓艾",
	["&pkJueXingDengAi"] = "邓艾",
	["#pkJueXingDengAi"] = "矫然的壮士",
	["designer:pkJueXingDengAi"] = "网络",
	["cv:pkJueXingDengAi"] = "烨子",
	["illustrator:pkJueXingDengAi"] = "KayaK",
	["~pkJueXingDengAi"] = "吾破蜀克敌，竟葬于奸贼之手！……",
}
--[[
	效果：分发起始手牌时，你将牌堆顶的三张牌作为“田”置于你的武将牌上。
]]--
JueXingDengAiEffect = sgs.CreateTriggerSkill{
	name = "#pkJueXingDengAiEffect",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DrawInitialCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local ids = room:getNCards(3)
		player:addToPile("field", ids)
		room:handleAcquireDetachSkills(player, "-#JueXingDengAiEffect")
		return false
	end,
}
--添加效果
JueXingDengAi:addSkill(JueXingDengAiEffect)
--[[
	技能：屯田
	描述：你的回合外，每当你失去一次牌后，你可以进行判定：若结果不为♥，将判定牌置于武将牌上，称为“田”。你与其他角色的距离-X。（X为“田”的数量） 
]]--
--添加技能
JueXingDengAi:addSkill("tuntian")
JueXingDengAi:addSkill("#tuntian-dist")
--[[
	技能：急袭
	描述：你可以将一张“田”当【顺手牵羊】使用。 
]]--
--添加技能
JueXingDengAi:addSkill("jixi")
--[[****************************************************************
	编号：PK - 008
	武将：觉醒姜维
	称号：龙的衣钵
	势力：蜀
	性别：男
	体力上限：3勾玉
]]--****************************************************************
JueXingJiangWei = sgs.General(extension, "pkJueXingJiangWei", "shu", 3, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkJueXingJiangWei"] = "觉醒姜维",
	["&pkJueXingJiangWei"] = "姜维",
	["#pkJueXingJiangWei"] = "龙的衣钵",
	["designer:pkJueXingJiangWei"] = "网络",
	["cv:pkJueXingJiangWei"] = "Jr. Wakaran，LeleK",
	["illustrator:pkJueXingJiangWei"] = "KayaK",
	["~pkJueXingJiangWei"] = "臣等正欲死战，陛下何故先降？……",
}
--[[
	技能：挑衅（阶段技）
	描述：你可以令攻击范围内包含你的一名角色对你使用一张【杀】，否则你弃置其一张牌。 
]]--
TiaoXinCard = sgs.CreateSkillCard{
	name = "pkTiaoXinCard",
	target_fixed = false,
	will_throw = true,
	filter = function(self, targets, to_select)
		if #targets == 0 then
			if to_select:isNude() then
				return false
			elseif sgs.Self:inMyAttackRange(to_select) then
				return true
			end
		end
		return false
	end,
	on_use = function(self, room, source, targets)
		local target = targets[1]
		local index = 1
		if source:hasArmorEffect("eight_diagram") then
			index = 3
		elseif source:hasArmorEffect("bazhen") then
			index = 3
		elseif source:getHp() >= target:getHp() then
			index = 2
		end
		room:broadcastSkillInvoke("pkTiaoXin", index) --播放配音
		room:notifySkillInvoked(source, "pkTiaoXin") --显示技能发动
		local use_slash = false
		if target:canSlash(source, nil, false) then
			local prompt = string.format("@tiaoxin-slash:%s", source:objectName())
			use_slash = room:askForUseSlashTo(target, source, prompt)
		end
		if use_slash then
			return 
		end
		if source:canDiscard(target, "he") then
			local id = room:askForCardChosen(source, target, "he", "pkTiaoXin", false, sgs.Card_MethodDiscard)
			if id > 0 then
				room:throwCard(id, target, source)
			end
		end
	end,
}
TiaoXin = sgs.CreateViewAsSkill{
	name = "pkTiaoXin",
	n = 0,
	view_as = function(self, cards)
		return TiaoXinCard:clone()
	end,
	enabled_at_play = function(self, player)
		return not player:hasUsed("#pkTiaoXinCard")
	end,
}
--添加技能
--JueXingJiangWei:addSkill("tiaoxin")
JueXingJiangWei:addSkill(TiaoXin)
--翻译信息
sgs.LoadTranslationTable{
	["pkTiaoXin"] = "挑衅",
	[":pkTiaoXin"] = "<font color=\"green\"><b>阶段技</b></font>，你可以令攻击范围内包含你的一名角色对你使用一张【杀】，否则你弃置其一张牌。 ",
	["$pkTiaoXin1"] = "贼将早降，可免一死！",
	["$pkTiaoXin2"] = "哼~贼将莫不是怕了？",
	["$pkTiaoXin3"] = "敌将可破得我八阵？",
	["pktiaoxin"] = "挑衅",
}
--[[
	技能：志继（限定技）
	描述：准备阶段开始时，若你没有手牌，你可以选择一项：回复1点体力，或摸两张牌。
]]--
ZhiJi = sgs.CreateTriggerSkill{
	name = "pkZhiJi",
	frequency = sgs.Skill_Limited,
	events = {sgs.EventPhaseStart},
	limit_mark = "@pkZhiJiMark",
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_Start then
			if player:isKongcheng() then
				if player:askForSkillInvoke("pkZhiJi", data) then
					local room = player:getRoom()
					room:broadcastSkillInvoke("pkZhiJi") --播放配音
					room:notifySkillInvoked(player, "pkZhiJi") --显示技能发动
					player:loseMark("@pkZhiJiMark", 1)
					local choice = "draw"
					if player:getLostHp() > 0 then
						choice = room:askForChoice(player, "zhiji", "recover+draw", data)
					end
					if choice == "recover" then
						local recover = sgs.RecoverStruct()
						recover.who = player
						recover.recover = 1
						room:recover(player, recover)
					elseif choice == "draw" then
						room:drawCards(player, 2, "pkZhiJi")
					end
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		if target and target:isAlive() then
			if target:hasSkill("pkZhiJi") then
				return target:getMark("@pkZhiJiMark") > 0
			end
		end
		return false
	end,
}
--添加技能
JueXingJiangWei:addSkill(ZhiJi)
--翻译信息
sgs.LoadTranslationTable{
	["pkZhiJi"] = "志继",
	[":pkZhiJi"] = "<font color=\"red\"><b>限定技</b></font>，准备阶段开始时，若你没有手牌，你可以选择一项：回复1点体力，或摸两张牌。",
	["$pkZhiJi"] = "今虽穷极，然先帝之志、丞相之托，维岂敢忘？！",
	["@pkZhiJiMark"] = "志继",
}
--[[
	技能：观星
	描述：准备阶段开始时，你可以观看牌堆顶的X张牌，然后将任意数量的牌置于牌堆顶，将其余的牌置于牌堆底。（X为存活角色数且至多为5） 
]]--
GuanXing = sgs.CreateTriggerSkill{
	name = "pkGuanXing",
	frequency = sgs.Skill_Frequent,
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_Start then
			if player:askForSkillInvoke("pkGuanXing", data) then
				local room = player:getRoom()
				room:broadcastSkillInvoke("pkGuanXing") --播放配音
				room:notifySkillInvoked(player, "pkGuanXing") --显示技能发动
				local count = room:alivePlayerCount()
				count = math.min(5, count)
				local card_ids = room:getNCards(count)
				local card_str = sgs.QList2Table(card_ids)
				card_str = table.concat(card_str, "+")
				local msg = sgs.LogMessage()
				msg.type = "$ViewDrawPile"
				msg.from = player
				msg.card_str = card_str
				room:sendLog(msg, player) --发送提示信息
				room:askForGuanxing(player, card_ids)
			end
		end
		return false
	end,
}
--添加技能
--JueXingJiangWei:addSkill("guanxing")
JueXingJiangWei:addSkill(GuanXing)
--翻译信息
sgs.LoadTranslationTable{
	["pkGuanXing"] = "观星",
	[":pkGuanXing"] = "准备阶段开始时，你可以观看牌堆顶的X张牌，然后将任意数量的牌置于牌堆顶，将其余的牌置于牌堆底。（X为存活角色数且至多为5）",
	["$pkGuanXing1"] = "系从尚父出，术奉武侯来！",
	["$pkGuanXing2"] = "北伐兴蜀汉，继志越祁山！",
}
--[[****************************************************************
	编号：PK - 009
	武将：觉醒神司马
	称号：晋国之祖
	势力：神
	性别：男
	体力上限：3勾玉
]]--****************************************************************
JueXingShenSiMa = sgs.General(extension, "pkJueXingShenSiMa", "god", 3, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkJueXingShenSiMa"] = "觉醒神司马",
	["&pkJueXingShenSiMa"] = "司马懿",
	["#pkJueXingShenSiMa"] = "晋国之祖",
	["designer:pkJueXingShenSiMa"] = "网络",
	["cv:pkJueXingShenSiMa"] = "泥马",
	["illustrator:pkJueXingShenSiMa"] = "KayaK",
	["~pkJueXingShenSiMa"] = "我已谋划至此，奈何……",
}
--[[
	效果：分发起始手牌时，你获得四枚“忍”标记。
]]--
JueXingShenSiMaEffect = sgs.CreateTriggerSkill{
	name = "#pkJueXingShenSiMaEffect",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DrawInitialCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		player:gainMark("@bear", 4)
		room:handleAcquireDetachSkills(player, "-#pkJueXingShenSiMaEffect")
		return false
	end,
}
--添加效果
JueXingShenSiMa:addSkill(JueXingShenSiMaEffect)
--[[
	技能：忍戒（锁定技）
	描述：每当你受到1点伤害后或于弃牌阶段因你的弃置而失去一张牌后，你获得一枚“忍”。 
]]--
JueXingShenSiMa:addSkill("renjie")
--[[
	技能：极略
	描述：你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”
]]--
JiLveCard = sgs.CreateSkillCard{
	name = "pkJiLveCard",
	target_fixed = true,
	will_throw = true,
	on_validate = function(self, use)
		local source = use.from
		local room = source:getRoom()
		local choices = {}
		if not source:hasFlag("JilveZhiheng") then
			if source:canDiscard(source, "he") then
				table.insert(choices, "zhiheng")
			end
		end
		if not source:hasFlag("JilveWansha") then
			table.insert(choices, "wansha")
		end
		table.insert(choices, "cancel")
		if #choices == 1 then
			return nil
		end
		choices = table.concat(choices, "+")
		local choice = room:askForChoice(source, "jilve", choices)
		if choice == "cancel" then
			return nil
		end
		source:loseMark("@bear", 1)
		room:notifySkillInvoked(source, "pkJiLve") --显示技能发动
		if choice == "wansha" then
			room:broadcastSkillInvoke("pkJiLve", 5) --播放配音
			room:setPlayerFlag(source, "JilveWansha")
			room:setPlayerMark(source, "pkJiLveWanSha", 1)
			room:handleAcquireDetachSkills(source, "wansha")
		elseif choice == "zhiheng" then
			room:broadcastSkillInvoke("pkJiLve", 4) --播放配音
			room:setPlayerFlag(source, "JilveZhiheng")
			room:askForUseCard(source, "@zhiheng", "@jilve-zhiheng", -1, sgs.Card_MethodDiscard)
		end
		return self
	end,
	on_use = function(self, room, source, targets)
		return nil
	end
}
JiLveVS = sgs.CreateViewAsSkill{
	name = "pkJiLve",
	n = 0,
	view_as = function(self, cards)
		return JiLveCard:clone()
	end,
	enabled_at_play = function(self, player)
		if player:getMark("@bear") == 0 then
			return false
		elseif player:usedTimes("#pkJiLveCard") >= 2 then
			return false
		end
		return true
	end,
}
JiLve = sgs.CreateTriggerSkill{
	name = "pkJiLve",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardUsed, sgs.AskForRetrial, sgs.Damaged},
	view_as_skill = JiLveVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		room:setPlayerMark(player, "JilveEvent", tonumber(event))
		if event == sgs.CardUsed then
			local use = data:toCardUse()
			local trick = use.card
			if trick and trick:isNDTrick() then
				if player:askForSkillInvoke("jilve_jizhi", data) then
					room:broadcastSkillInvoke("pkJiLve", 3) --播放配音
					room:notifySkillInvoked(player, "pkJiLve") --显示技能发动
					player:loseMark("@bear", 1)
					room:drawCards(player, 1, "nosjizhi")
				end
			end
		elseif event == sgs.AskForRetrial then
			if player:isKongcheng() then
				return false
			end
			if player:askForSkillInvoke("jilve_guicai", data) then
				room:notifySkillInvoked(player, "pkJiLve") --显示技能发动
				player:loseMark("@bear", 1)
				local judge = data:toJudge()
				local target = judge.who
				local id = judge.card:getEffectiveId()
				local prompt = string.format("@guicai-card:%s:%s:%s:%d", target:objectName(), "guicai", judge.reason, id)
				local card = room:askForCard(player, ".!", prompt, data, sgs.Card_MethodResponse, target, true)
				card = card or player:getRandomHandCard()
				if card then
					room:broadcastSkillInvoke("pkJiLve", 1) --播放配音
					room:retrial(card, player, judge, "guicai")
				end
			end
		elseif event == sgs.Damaged then
			if player:askForSkillInvoke("jilve_fangzhu", data) then
				room:notifySkillInvoked(player, "pkJiLve") --显示技能发动
				player:loseMark("@bear", 1)
				local others = room:getOtherPlayers(player)
				local target = room:askForPlayerChosen(player, others, "fangzhu", "fangzhu-invoke", false, true)
				if target then
					room:broadcastSkillInvoke("pkJiLve", 2) --播放配音
					local x = player:getLostHp()
					room:drawCards(target, x, "pkJiLve")
					target:turnOver()
				end
			end
		end
		room:setPlayerMark(player, "JilveEvent", 0)
		return false
	end,
	can_trigger = function(self, target)
		if target and target:isAlive() then
			if target:hasSkill("pkJiLve") then
				return target:getMark("@bear") > 0
			end
		end
		return false
	end,
}
JiLveClear = sgs.CreateTriggerSkill{
	name = "#pkJiLveClear",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.EventPhaseStart, sgs.EventPhaseEnd},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getMark("JilveEvent") > 0 then
				room:setPlayerMark(player, "JilveEvent", 0)
			end
		elseif event == sgs.EventPhaseEnd then
			if player:getMark("pkJiLveWanSha") > 0 and player:hasSkill("wansha") then
				room:handleAcquireDetachSkills(player, "-wansha", true)
			end
		end
	end,
}
extension:insertRelatedSkills("pkJiLve", "#pkJiLveClear")
--添加技能
JueXingShenSiMa:addSkill(JiLve)
JueXingShenSiMa:addSkill(JiLveClear)
--翻译信息
sgs.LoadTranslationTable{
	["pkJiLve"] = "极略",
	[":pkJiLve"] = "你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”",
	["$pkJiLve1"] = "天意如何，我命由我！",
	["$pkJiLve2"] = "远逐敌雠，拔除异己。",
	["$pkJiLve3"] = "此计既成，彼计亦得。",
	["$pkJiLve4"] = "暂且思量，再做打算。",
	["$pkJiLve5"] = "心狠手毒，方能成事！",
	["pkjilve"] = "极略",
}
--[[****************************************************************
	编号：PK - 010
	武将：原版神司马
	称号：晋国之祖
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
YuanBanShenSiMa = sgs.General(extension, "pkYuanBanShenSiMa", "god", 4, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkYuanBanShenSiMa"] = "原版神司马",
	["&pkYuanBanShenSiMa"] = "司马懿",
	["#pkYuanBanShenSiMa"] = "晋国之祖",
	["designer:pkYuanBanShenSiMa"] = "网络",
	["cv:pkYuanBanShenSiMa"] = "泥马",
	["illustrator:pkYuanBanShenSiMa"] = "KayaK",
	["~pkYuanBanShenSiMa"] = "我已谋划至此，奈何……",
}
--[[
	技能：忍戒（锁定技）
	描述：每当你受到1点伤害后或于弃牌阶段因你的弃置而失去一张牌后，你获得一枚“忍”。 
]]--
YuanBanShenSiMa:addSkill("renjie")
--[[
	技能：拜印（觉醒技）
	描述：准备阶段开始时，若你拥有四枚或更多的“忍”，你失去1点体力上限，然后获得“极略”（你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”）。 
]]--
BaiYin = sgs.CreateTriggerSkill{
	name = "pkBaiYin",
	frequency = sgs.Skill_Wake,
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_Start then
			if player:getMark("@bear") >= 4 then
				local room = player:getRoom()
				room:broadcastSkillInvoke("pkBaiYin") --播放配音
				room:notifySkillInvoked(player, "pkBaiYin") --显示技能发动
				room:setPlayerMark(player, "pkBaiYinWaked", 1)
				local msg = sgs.LogMessage()
				msg.type = "#BaiyinWake"
				msg.from = player
				msg.arg = player:getMark("@bear")
				room:sendLog(msg) --发送提示信息
				if room:changeMaxHpForAwakenSkill(player) then
					room:handleAcquireDetachSkills(player, "pkJiLve")
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		if target and target:getMark("pkBaiYinWaked") == 0 then
			if target:isAlive() and target:hasSkill("pkBaiYin") then
				return true
			end
		end
		return false
	end,
}
--添加技能
YuanBanShenSiMa:addSkill(BaiYin)
--翻译信息
sgs.LoadTranslationTable{
	["pkBaiYin"] = "拜印",
	[":pkBaiYin"] = "<font color=\"purple\"><b>觉醒技</b></font>，准备阶段开始时，若你拥有四枚或更多的“忍”，你失去1点体力上限，然后获得“极略”（你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”）。",
	["$pkBaiYin"] = "是可忍，孰不可忍？！",
}
--[[
	技能：连破
	描述：每当一名角色的回合结束后，若你于本回合杀死至少一名角色，你可以进行一个额外的回合。 
]]--
--添加技能
YuanBanShenSiMa:addSkill("lianpo")
--[[
	技能：极略
	描述：你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”
]]--
--添加技能
YuanBanShenSiMa:addRelateSkill("pkJiLve")
--[[****************************************************************
	编号：PK - 011
	武将：自修孙坚
	称号：武烈帝
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
ZiXiuSunJian = sgs.General(extension, "pkZiXiuSunJian", "wu", 4, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkZiXiuSunJian"] = "自修孙坚",
	["&pkZiXiuSunJian"] = "孙坚",
	["#pkZiXiuSunJian"] = "武烈帝",
	["designer:pkZiXiuSunJian"] = "网络",
	["cv:pkZiXiuSunJian"] = "木津川",
	["illustrator:pkZiXiuSunJian"] = "LiuHeng",
	["~pkZiXiuSunJian"] = "死去何愁无勇将，英魂依旧卫江东……",
}
--[[
	技能：自修
	描述：准备阶段开始时，你可以摸X张牌（X为你已损失的体力值）。
]]--
ZiXiu = sgs.CreateTriggerSkill{
	name = "pkZiXiu",
	frequency = sgs.Skill_Frequent,
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_Start then
			local x = player:getLostHp()
			if x > 0 then
				if player:askForSkillInvoke("pkZiXiu", data) then
					local room = player:getRoom()
					room:broadcastSkillInvoke("pkZiXiu") --播放配音
					room:notifySkillInvoked(player, "pkZiXiu") --显示技能发动
					room:drawCards(player, x, "pkZiXiu")
				end
			end
		end
		return false
	end,
}
--添加技能
ZiXiuSunJian:addSkill(ZiXiu)
--翻译信息
sgs.LoadTranslationTable{
	["pkZiXiu"] = "自修",
	[":pkZiXiu"] = "准备阶段开始时，你可以摸X张牌（X为你已损失的体力值）。",
	["$pkZiXiu"] = "技能 自修 的台词",
}
--[[****************************************************************
	编号：PK - 012
	武将：变限白板
	称号：测试员
	势力：神
	性别：男
	体力上限：0勾玉
]]--****************************************************************
BianXianBaiBan = sgs.General(extension, "pkBianXianBaiBan", "god", 0, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["pkBianXianBaiBan"] = "变限白板",
	["&pkBianXianBaiBan"] = "白板",
	["#pkBianXianBaiBan"] = "测试员",
	["designer:pkBianXianBaiBan"] = "网络",
	["cv:pkBianXianBaiBan"] = "无",
	["illustrator:pkBianXianBaiBan"] = "无",
	["~pkBianXianBaiBan"] = "……",
}
--[[
	效果：分发起始手牌时，你将体力上限与体力重置为既定值。
]]--
BianXianBaiBanEffect = sgs.CreateTriggerSkill{
	name = "#pkBianXianBaiBanEffect",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DrawInitialCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local x = sgs.QVariant(math.max(0, BianXianBaiBan_MaxHp))
		room:setPlayerProperty(player, "maxhp", x)
		room:setPlayerProperty(player, "hp", x)
		room:handleAcquireDetachSkills(player, "-#pkBianXianBaiBanEffect")
		return false
	end,
}
--添加效果
BianXianBaiBan:addSkill(BianXianBaiBanEffect)