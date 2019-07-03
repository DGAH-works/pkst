--[[
	太阳神三国杀武将扩展包·单挑测试（AI部分）
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
function SmartAI:useSkillCard(card, use)
	local name
	if card:isKindOf("LuaSkillCard") then
		name = "#" .. card:objectName()
	else
		name = card:getClassName()
	end
	if sgs.ai_skill_use_func[name] then
		sgs.ai_skill_use_func[name](card, use, self)
		if use.to then
			if not use.to:isEmpty() and sgs.dynamic_value.damage_card[name] then
				for _, target in sgs.qlist(use.to) do
					if self:damageIsEffective(target) then return end
				end
				use.card = nil
			end
		end
		return
	end
	if self["useCard"..name] then
		self["useCard"..name](self, card, use)
	end
end
--[[****************************************************************
	编号：PK - 001
	武将：四限英姿
	称号：测试员
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
--[[
	技能：英姿
	描述：摸牌阶段，你可以额外摸一张牌。
]]--
--room:askForSkillInvoke(player, "pkYingZiX", data)
sgs.ai_skill_invoke["pkYingZiX"] = true
--[[****************************************************************
	编号：PK - 002
	武将：三限英闭
	称号：测试员
	势力：神
	性别：男
	体力上限：3勾玉
]]--****************************************************************
--[[
	技能：英姿
	描述：摸牌阶段，你可以额外摸一张牌。
]]--
--[[
	技能：闭月
	描述：回合结束阶段开始时，你可以摸一张牌。
]]--
--[[****************************************************************
	编号：PK - 003
	武将：稳定一杀
	称号：测试员
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
--[[
	技能：杀使（阶段技）
	描述：出牌阶段，若你未使用过【杀】：你可以将一张牌当做【杀】使用；若你没有牌，你可以视为使用一张【杀】。
		锁定技，你以此法使用的【杀】无距离限制。
]]--
--ShaShiVS:Play
local shashi_skill = {
	name = "pkShaShi",
	getTurnUseCard = function(self, inclusive)
		if self.player:hasFlag("pkShaShiInvoked") then
			return nil
		elseif sgs.Slash_IsAvailable(self.player) then
			if self.player:getPhase() == sgs.Player_Play then
				if self.player:getSlashCount() == 0 then
					if self.player:isNude() then
						local card_str = "slash:pkShaShi[no_suit:0]=."
						return sgs.Card_Parse(card_str)
					else
						local cards = self.player:getCards("he")
						cards = sgs.QList2Table(cards)
						self:sortByUseValue(cards, true)
						local card = cards[1]
						local suit = card:getSuitString()
						local point = card:getNumber()
						local id = card:getEffectiveId()
						local card_str = string.format("slash:pkShaShi[%s:%d]=%d", suit, point, id)
						return sgs.Card_Parse(card_str)
					end
				end
			end
		end
	end,
}
table.insert(sgs.ai_skills, shashi_skill)
--[[****************************************************************
	编号：PK - 004
	武将：一起神云
	称号：神威如龙
	势力：神
	性别：男
	体力上限：2勾玉
]]--****************************************************************
--[[
	技能：绝境（锁定技）
	描述：摸牌阶段，你额外摸X张牌（X为你已损失的体力）；你的手牌上限+2。
]]--
--[[
	技能：龙魂
	描述：你可以将X张黑桃/红心/草花/方块牌当做【无懈可击】/【桃】/【闪】/火【杀】使用或打出。（X为你的体力且至少为1）
]]--
--[[****************************************************************
	编号：PK - 005
	武将：觉醒策
	称号：江东的小霸王
	势力：吴
	性别：男
	体力上限：3勾玉
]]--****************************************************************
--[[
	技能：激昂
	描述：每当你使用一张【决斗】或红色的【杀】时，你可以摸一张牌；每当你成为一张【决斗】或红色【杀】的目标时，你可以摸一张牌。
]]--
--player:askForSkillInvoke("pkJiAng", data)
sgs.ai_skill_invoke["pkJiAng"] = true
--[[
	技能：英姿
	描述：摸牌阶段，你可以额外摸一张牌。
]]--
--room:askForSkillInvoke(player, "pkYingZi", data)
sgs.ai_skill_invoke["pkYingZi"] = true
--[[
	技能：英魂
	描述：准备阶段开始时，若你已受伤，你可以指定一名其他角色并选择一项：1、令该角色摸X张牌，然后弃1张牌；2、令该角色摸1张牌，然后弃X张牌。（X为你已损失的体力）
]]--
--room:askForDiscard(target, "pkYingHun", discard, discard, false, true)
--room:askForPlayerChosen(player, others, "pkYingHun", "yinghun-invoke", true, true)
sgs.ai_skill_playerchosen["pkYingHun"] = sgs.ai_skill_playerchosen["yinghun"]
--room:askForChoice(player, "pkYingHun", "d1tx+dxt1", ai_data)
sgs.ai_skill_choice["pkYingHun"] = function(self, choices, data)
	local target = data:toPlayer()
	local result = nil
	target:setFlags("YinghunTarget")
	local callback = sgs.ai_skill_choice["yinghun"]
	if type(callback) == "string" then
		result = callback
	elseif type(callback) == "function" then
		result = callback(self, choices, data)
	end
	target:setFlags("-YinghunTarget")
	return result
end
--相关信息
sgs.ai_playerchosen_intention["pkYingHun"] = sgs.ai_playerchosen_intention.yinghun
sgs.ai_choicemade_filter.skillChoice["pkYingHun"] = sgs.ai_choicemade_filter.skillChoice.yinghun
--[[****************************************************************
	编号：PK - 006
	武将：觉醒钟会
	称号：桀骜的野心家
	势力：魏
	性别：男
	体力上限：3勾玉
]]--****************************************************************
--[[
	技能：权计
	描述：每当你受到1点伤害后，你可以摸一张牌，然后将一张手牌置于武将牌上，称为“权”。每有一张“权”，你的手牌上限+1。 
]]--
--[[
	技能：自立（限定技）
	描述：准备阶段开始时，若“权”的数目不少于3，你可以选择一项：回复1点体力，或摸两张牌。
]]--
--player:askForSkillInvoke("pkZiLi", data)
sgs.ai_skill_invoke["pkZiLi"] = function(self, data)
	return self:isWeak()
end
--room:askForChoice(player, "zili", "recover+draw", data)
--[[
	技能：排异（阶段技）
	描述：你可以将一张“权”置入弃牌堆并选择一名角色：若如此做，该角色摸两张牌：若其手牌多于你，该角色受到1点伤害。
]]--
--[[****************************************************************
	编号：PK - 007
	武将：觉醒邓艾
	称号：矫然的壮士
	势力：魏
	性别：男
	体力上限：3勾玉
]]--****************************************************************
--[[
	技能：屯田
	描述：你的回合外，每当你失去一次牌后，你可以进行判定：若结果不为♥，将判定牌置于武将牌上，称为“田”。你与其他角色的距离-X。（X为“田”的数量） 
]]--
--[[
	技能：急袭
	描述：你可以将一张“田”当【顺手牵羊】使用。 
]]--
--[[****************************************************************
	编号：PK - 008
	武将：觉醒姜维
	称号：龙的衣钵
	势力：蜀
	性别：男
	体力上限：3勾玉
]]--****************************************************************
--[[
	技能：挑衅（阶段技）
	描述：你可以令攻击范围内包含你的一名角色对你使用一张【杀】，否则你弃置其一张牌。 
]]--
--room:askForUseSlashTo(target, source, prompt)
--room:askForCardChosen(source, target, "he", "pkTiaoXin", false, sgs.Card_MethodDiscard)
--TiaoXinCard:Play
local tiaoxin_skill = {
	name = "pkTiaoXin",
	getTurnUseCard = function(self, inclusive)
		if self.player:hasUsed("#pkTiaoXinCard") then
			return nil
		end
		return sgs.Card_Parse("#pkTiaoXinCard:.:")
	end,
}
table.insert(sgs.ai_skills, tiaoxin_skill)
sgs.ai_skill_use_func["#pkTiaoXinCard"] = function(card, use, self)
	local distance = use.DefHorse and 1 or 0
	local targets = {}
	for _, enemy in ipairs(self.enemies) do
		if enemy:distanceTo(self.player, distance) <= enemy:getAttackRange() and not self:doNotDiscard(enemy) and self:isTiaoxinTarget(enemy) then
			table.insert(targets, enemy)
		end
	end
	if #targets == 0 then return end
	sgs.ai_use_priority["pkTiaoXinCard"] = 8
	if not self.player:getArmor() and not self.player:isKongcheng() then
		for _, c in sgs.qlist(self.player:getCards("h")) do
			if c:isKindOf("Armor") and self:evaluateArmor(c) > 3 then
				sgs.ai_use_priority["pkTiaoXinCard"] = 5.9
				break
			end
		end
	end
	if use.to then
		self:sort(targets, "defenseSlash")
		use.to:append(targets[1])
	end
	use.card = sgs.Card_Parse("#pkTiaoXinCard:.:")
end
--相关信息
sgs.ai_card_intention["pkTiaoxinCard"] = 80
sgs.ai_use_priority["pkTiaoxinCard"] = 4
--[[
	技能：志继（限定技）
	描述：准备阶段开始时，若你没有手牌，你可以选择一项：回复1点体力，或摸两张牌。
]]--
--player:askForSkillInvoke("pkZhiJi", data)
sgs.ai_skill_invoke["pkZhiJi"] = function(self, data)
	return self:isWeak()
end
--room:askForChoice(player, "zhiji", "recover+draw", data)
--[[
	技能：观星
	描述：准备阶段开始时，你可以观看牌堆顶的X张牌，然后将任意数量的牌置于牌堆顶，将其余的牌置于牌堆底。（X为存活角色数且至多为5） 
]]--
--player:askForSkillInvoke("pkGuanXing", data)
sgs.ai_skill_invoke["pkGuanXing"] = true
--room:askForGuanxing(player, card_ids)
--[[****************************************************************
	编号：PK - 009
	武将：觉醒神司马
	称号：晋国之祖
	势力：神
	性别：男
	体力上限：3勾玉
]]--****************************************************************
--[[
	技能：忍戒（锁定技）
	描述：每当你受到1点伤害后或于弃牌阶段因你的弃置而失去一张牌后，你获得一枚“忍”。 
]]--
local system_needBear = SmartAI.needBear
function SmartAI:needBear(player)
	player = player or self.player
	if player:hasSkills("renjie+pkBaiYin") and not player:hasSkill("pkJiLve") and player:getMark("@bear") < 4 then
		return true
	end
	return system_needBear(self, player)
end
--[[
	技能：极略
	描述：你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”
]]--
--room:askForChoice(source, "jilve", choices)
--room:askForUseCard(source, "@zhiheng", "@jilve-zhiheng", -1, sgs.Card_MethodDiscard)
--JiLveCard:Play
local jilve_skill = {
	name = "pkJiLve",
	getTurnUseCard = function(self, inclusive)
		if self.player:getMark("@bear") == 0 then
			return nil
		elseif self.player:usedTimes("#pkJiLveCard") >= 2 then
			return nil
		end
		if self.player:hasFlag("JilveWansha") and self.player:hasFlag("JilveZhiheng") then 
			return nil
		end
		local wanshadone = self.player:hasFlag("JilveWansha")
		if not wanshadone and not self.player:hasSkill("wansha") and #self.enemies > 1 then
			self:sort(self.enemies, "hp")
			for _, enemy in ipairs(self.enemies) do
				if not (enemy:hasSkill("kongcheng") and enemy:isKongcheng()) and self:isWeak(enemy) and self:damageMinusHp(self, enemy, 1) > 0 then
					sgs.ai_skill_choice.jilve = "wansha"
					sgs.ai_use_priority["pkJiLveCard"] = 8
					return sgs.Card_Parse("#pkJiLveCard:.:")
				end
			end
		end
		if not self.player:hasFlag("JilveZhiheng") then
			sgs.ai_skill_choice.jilve = "zhiheng"
			sgs.ai_use_priority["pkJiLveCard"] = sgs.ai_use_priority.ZhihengCard
			local card = sgs.Card_Parse("@ZhihengCard=.")
			local dummy_use = { 
				isDummy = true 
			}
			self:useSkillCard(card, dummy_use)
			if dummy_use.card then 
				return sgs.Card_Parse("#pkJiLveCard:.:") 
			end
		end
	end,
}
table.insert(sgs.ai_skills, jilve_skill)
sgs.ai_skill_use_func["#pkJiLveCard"] = function(card, use, self)
	use.card = card
end
--player:askForSkillInvoke("jilve_jizhi", data)
--player:askForSkillInvoke("jilve_guicai", data)
--room:askForCard(player, ".!", prompt, data, sgs.Card_MethodResponse, target, true)
--player:askForSkillInvoke("jilve_fangzhu", data)
--room:askForPlayerChosen(player, others, "fangzhu", "fangzhu-invoke", false, true)
--[[****************************************************************
	编号：PK - 010
	武将：原版神司马
	称号：晋国之祖
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
--[[
	技能：忍戒（锁定技）
	描述：每当你受到1点伤害后或于弃牌阶段因你的弃置而失去一张牌后，你获得一枚“忍”。 
]]--
--[[
	技能：拜印（觉醒技）
	描述：准备阶段开始时，若你拥有四枚或更多的“忍”，你失去1点体力上限，然后获得“极略”（你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”）。 
]]--
--[[
	技能：连破
	描述：每当一名角色的回合结束后，若你于本回合杀死至少一名角色，你可以进行一个额外的回合。 
]]--
--[[
	技能：极略
	描述：你可以弃一枚“忍”并发动以下技能之一：“鬼才”、“放逐”、“集智”、“制衡”、“完杀”
]]--
--[[****************************************************************
	编号：PK - 011
	武将：自修孙坚
	称号：武烈帝
	势力：神
	性别：男
	体力上限：4勾玉
]]--****************************************************************
--[[
	技能：自修
	描述：准备阶段开始时，你可以摸X张牌（X为你已损失的体力值）。
]]--
--player:askForSkillInvoke("pkZiXiu", data)
sgs.ai_skill_invoke["pkZiXiu"] = true
--[[****************************************************************
	编号：PK - 012
	武将：变限白板
	称号：测试员
	势力：神
	性别：男
	体力上限：0勾玉
]]--****************************************************************