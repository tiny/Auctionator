local addonName, addonTable = ...;
local ZT = addonTable.ztt.ZT;
local zc = addonTable.zc;
local zz = zc.md;
local _

AtrQuery = {};
AtrQuery.__index = AtrQuery;

--[ extended filters ]---------------------------------------------------------

-- subst 
--  lookup variable and return literal value
--
local subst = {} ;
subst['head']      = "is('INVTYPE_HEAD')" ;
subst['helm']      = "is('INVTYPE_HEAD')" ;
subst['neck']      = "is('INVTYPE_NECK')" ;
subst['shoulder']  = "is('INVTYPE_SHOULDER')" ;
subst['shoulders'] = "is('INVTYPE_SHOULDER')" ;
subst['back']      = "is('INVTYPE_CLOAK')" ;
subst['chest']     = "is('INVTYPE_CHEST') or is('INVTYPE_ROBE')" ;
subst['shirt']     = "is('INVTYPE_BODY')" ;
subst['wrist']     = "is('INVTYPE_WRIST')" ;
subst['hand']      = "is('INVTYPE_HAND')" ;
subst['hands']     = "is('INVTYPE_HAND')" ;
subst['waist']     = "is('INVTYPE_WAIST')" ;
subst['legs']      = "is('INVTYPE_LEGS')" ;
subst['feet']      = "is('INVTYPE_FEET')" ;
subst['boots']     = "is('INVTYPE_FEET')" ;
subst['finger']    = "is('INVTYPE_FINGER')" ;
subst['trinket']   = "is('INVTYPE_TRINKET')" ;
subst['one-hand']  = "is('INVTYPE_WEAPON')" ;
subst['mace']      = "isSubType('One-Handed Maces')" ;
subst['maces']     = "isSubType('One-Handed Maces')" ;
subst['axe']       = "isSubType('One-Handed Axes')" ;
subst['axes']      = "isSubType('One-Handed Axes')" ;
subst['sword']     = "isSubType('One-Handed Swords')" ;
subst['swords']    = "isSubType('One-Handed Swords')" ;
subst['2h-mace']   = "isSubType('Two-Handed Maces')" ;
subst['2h-axe']    = "isSubType('Two-Handed Axes')" ;
subst['2h-sword']  = "isSubType('Two-Handed Swords')" ;
subst['2h-maces']  = "isSubType('Two-Handed Maces')" ;
subst['2h-axes']   = "isSubType('Two-Handed Axes')" ;
subst['2h-swords'] = "isSubType('Two-Handed Swords')" ;
subst['dagger']    = "isSubType('Daggers')" ;
subst['daggers']   = "isSubType('Daggers')" ;
subst['two-hand']  = "is('INVTYPE_2HWEAPON')" ;
subst['staves']    = "isSubType('Staves')" ;
subst['weapon']    = "(one-hand or two-hand)" ;
subst['shield']    = "is('INVTYPE_SHIELD')" ;
subst['bow']       = "isSubType('Bows')" ;
subst['gun']       = "isSubType('Guns')" ;
subst['wand']      = "isSubType('Wands')" ;
subst['main-hand'] = "is('INVTYPE_WEAPONMAINHAND')" ;
subst['off-hand']  = "is('INVTYPE_WEAPONOFFHAND')" ;
subst['bag']       = "is('INVTYPE_BAG')" ;
subst['quiver']    = "is('INVTYPE_QUIVER')" ;
subst['armor']     = "isType('Armor')" ;
subst['plate']     = "isSubType('Plate')" ;
subst['mail']      = "isSubType('Mail')" ;
subst['leather']   = "isSubType('Leather')" ;
subst['cloth']     = "isSubType('Cloth')" ;
subst['potion']    = "isSubType('Potion')" ;
subst['flask']     = "isSubType('Flask')" ;
subst['elixir']    = "isSubType('Elixir')" ;
subst['food']      = "isSubType('Food & Drink')" ;
subst['scroll']    = "isSubType('Scroll')" ;
subst['dps']       = "does(dps)" ;

-- generated from s_bonusStatStringTags
local bonusStats = {
[0] = "ITEM_MOD_MANA_SHORT",
[1] = "ITEM_MOD_HEALTH_SHORT",
[3] = "ITEM_MOD_AGILITY_SHORT",
[4] = "ITEM_MOD_STRENGTH_SHORT",
[5] = "ITEM_MOD_INTELLECT_SHORT",
[6] = "ITEM_MOD_SPIRIT_SHORT",
[7] = "ITEM_MOD_STAMINA_SHORT",
[12] = "ITEM_MOD_DEFENSE_SKILL_RATING_SHORT",
[13] = "ITEM_MOD_DODGE_RATING_SHORT",
[14] = "ITEM_MOD_PARRY_RATING_SHORT",
[15] = "ITEM_MOD_BLOCK_RATING_SHORT",
[16] = "ITEM_MOD_HIT_MELEE_RATING_SHORT",
[17] = "ITEM_MOD_HIT_RANGED_RATING_SHORT",
[18] = "ITEM_MOD_HIT_SPELL_RATING_SHORT",
[19] = "ITEM_MOD_CRIT_MELEE_RATING_SHORT",
[20] = "ITEM_MOD_CRIT_RANGED_RATING_SHORT",
[21] = "ITEM_MOD_CRIT_SPELL_RATING_SHORT",
[22] = "ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT",
[23] = "ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT",
[24] = "ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT",
[25] = "ITEM_MOD_CRIT_TAKEN_MELEE_RATING_SHORT",
[26] = "ITEM_MOD_CRIT_TAKEN_RANGED_RATING_SHORT",
[27] = "ITEM_MOD_CRIT_TAKEN_SPELL_RATING_SHORT",
[28] = "ITEM_MOD_HASTE_MELEE_RATING_SHORT",
[29] = "ITEM_MOD_HASTE_RANGED_RATING_SHORT",
[30] = "ITEM_MOD_HASTE_SPELL_RATING_SHORT",
[31] = "ITEM_MOD_HIT_RATING_SHORT",
[32] = "ITEM_MOD_CRIT_RATING_SHORT",
[33] = "ITEM_MOD_HIT_TAKEN_RATING_SHORT",
[34] = "ITEM_MOD_CRIT_TAKEN_RATING_SHORT",
[35] = "ITEM_MOD_RESILIENCE_RATING_SHORT",
[36] = "ITEM_MOD_HASTE_RATING_SHORT",
[37] = "ITEM_MOD_EXPERTISE_RATING_SHORT",
[38] = "ITEM_MOD_ATTACK_POWER_SHORT",
[39] = "ITEM_MOD_RANGED_ATTACK_POWER_SHORT",
[40] = "ITEM_MOD_VERSATILITY",
[41] = "ITEM_MOD_SPELL_HEALING_DONE_SHORT",
[42] = "ITEM_MOD_SPELL_DAMAGE_DONE_SHORT",
[43] = "ITEM_MOD_MANA_REGENERATION_SHORT",
[44] = "ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT",
[45] = "ITEM_MOD_SPELL_POWER_SHORT",
[46] = "ITEM_MOD_HEALTH_REGEN_SHORT",
[47] = "ITEM_MOD_SPELL_PENETRATION_SHORT",
[48] = "ITEM_MOD_BLOCK_VALUE_SHORT",
[49] = "ITEM_MOD_MASTERY_RATING_SHORT",
[50] = "ITEM_MOD_EXTRA_ARMOR_SHORT",
[51] = "ITEM_MOD_FIRE_RESISTANCE_SHORT",
[52] = "ITEM_MOD_FROST_RESISTANCE_SHORT",
[53] = "ITEM_MOD_HOLY_RESISTANCE_SHORT",
[54] = "ITEM_MOD_SHADOW_RESISTANCE_SHORT",
[55] = "ITEM_MOD_NATURE_RESISTANCE_SHORT",
[56] = "ITEM_MOD_ARCANE_RESISTANCE_SHORT",
[57] = "ITEM_MOD_PVP_POWER_SHORT",
[58] = "ITEM_MOD_CR_AMPLIFY_SHORT",
[59] = "ITEM_MOD_CR_MULTISTRIKE_SHORT",
[60] = "ITEM_MOD_CR_READINESS_SHORT",
[61] = "ITEM_MOD_CR_SPEED_SHORT",
[62] = "ITEM_MOD_CR_LIFESTEAL_SHORT",
[63] = "ITEM_MOD_CR_AVOIDANCE_SHORT",
[64] = "ITEM_MOD_CR_STURDINESS_SHORT",
[65] = "ITEM_MOD_CR_UNUSED_7_SHORT",
[66] = "ITEM_MOD_CR_CLEAVE_SHORT",
[67] = "ITEM_MOD_CR_UNUSED_9_SHORT",
[68] = "ITEM_MOD_CR_UNUSED_10_SHORT",
[69] = "ITEM_MOD_CR_UNUSED_11_SHORT",
[70] = "ITEM_MOD_CR_UNUSED_12_SHORT",
[98] = "ITEM_MOD_DAMAGE_PER_SECOND_SHORT"
} ;

local statMap = {} ;
statMap[ 'str'      ] =   4 ;
statMap[ 'strength' ] =   4 ;
statMap[ 'mana'     ] =   0 ;
statMap[ 'hp'       ] =   1 ;
statMap[ 'health'   ] =   1 ;
statMap[ 'agi'      ] =   3 ;
statMap[ 'agility'  ] =   3 ;
statMap[ 'dex'      ] =   3 ;
statMap[ 'int'      ] =   5 ;
statMap[ 'intellect'] =   5 ;
statMap[ 'spirit'   ] =   6 ;
statMap[ 'spr'      ] =   6 ;
statMap[ 'stamina'  ] =   7 ;
statMap[ 'sta'      ] =   7 ;
statMap[ 'stam'     ] =   7 ;
statMap[ 'dodge'    ] =  13 ;
statMap[ 'parry'    ] =  14 ;
statMap[ 'block'    ] =  15 ;
statMap[ 'hit'      ] =  16 ;
statMap[ 'crit'     ] =  19 ;
statMap[ 'haste'    ] =  28 ;
statMap[ 'attack'   ] =  38 ;
statMap[ 'fire'     ] =  51 ;
statMap[ 'frost'    ] =  52 ;
statMap[ 'holy'     ] =  53 ;
statMap[ 'shadow'   ] =  54 ;
statMap[ 'nature'   ] =  55 ;
statMap[ 'arcane'   ] =  56 ;
statMap[ 'dps'      ] =  98 ;

local function isEquipLoc( item, pos )
   return (item and item._info.itemEquipLoc and (item._info.itemEquipLoc == pos)) ;
end

local function isType( item, pos )
   return (item and item._info.itemType and (item._info.itemType == pos)) ;
end

local function isSubType( item, pos )
   return (item and item._info.itemSubType and (item._info.itemSubType == pos)) ;
end

local function level( item, arg1, arg2 ) 
   local lo = tonumber(arg1) ;
   local hi = tonumber(arg2) ;
   if (lo == nil) or (hi == nil) then
      return false ;
   end
   return ((item._info.itemMinLevel >= lo) and (item._info.itemMinLevel <= hi)) ;
end

local _stat_set = {} ;
local function hasStat( item, arg1 ) 
  GetItemStats( item._info.itemLink, _stat_set ) ;
  local rc = nil ;
  if (statMap[arg1] and bonusStats[statMap[ arg1 ]]) then
    rc = _stat_set[ bonusStats[statMap[ arg1 ]] ] ;
  end

--  kept for debug purposes
--  print( "-- ".. tostring(item.name) .." ") ;
--  for i,v in pairs(_stat_set) do
--    print( "  [".. tostring(i) .."]  [".. tostring(v) .."]" ) ;
--  end
--  print( "-- arg(".. tostring(arg1) ..")  rc: ".. tostring(rc) );
  table.wipe( _stat_set ) ;
  return rc ;
end

local function statDoes( item, arg1 ) 
  GetItemStats( item._info.itemLink, _stat_set ) ;
  local rc = nil ;
  if (statMap[arg1] and bonusStats[statMap[ arg1 ]]) then
    rc = _stat_set[ bonusStats[statMap[ arg1 ]] ] ;
  end
  table.wipe( _stat_set ) ;
  return tonumber(rc or 0) ;
end

-- oper
-- functional map
--
local oper = {} ;
oper['&'] = function(a,b) return a and b ; end
oper['|'] = function(a,b) return a  or b ; end
oper['<'] = function(a,b) return a   < b ; end
oper['>'] = function(a,b) return a   > b ; end

local function eval( item, exp, valueTab, loopValue)
   -- !{COND} - negate
   exp = strtrim( exp or "", " " ) ;
   if (valueTab == nil) then
      valueTab = 1 ;
   end
   if (exp == "") then
      return false ;
   end
   
   -- logical and
   if (string.find(exp, '^(.+) and (.+)')) then
      local arg1 = strtrim( string.gsub(exp, '^(.+) and (.+)', '%1'), " " );
      local arg2 = strtrim( string.gsub(exp, '^(.+) and (.+)', '%2'), " " );
      return eval( item, arg1, valueTab ) and eval( item, arg2, valueTab ) ;
   end
   
   -- logical or
   if (string.find(exp, '^(.+) or (.+)$')) then
      local arg1 = strtrim( string.gsub(exp, '^(.+) or (.+)$', '%1'), " " );
      local arg2 = strtrim( string.gsub(exp, '^(.+) or (.+)$', '%2'), " " );
      return eval( item, arg1, valueTab ) or eval( item, arg2, valueTab ) ;
   end   
   
   -- logical and, or
   local expr = '^(.+)([&|])(.+)' ;
   if (string.find(exp, expr )) then
      local arg1 = strtrim( string.gsub(exp, expr, '%1'), " " );
      local op   = strtrim( string.gsub(exp, expr, '%2'), " " );
      local arg2 = strtrim( string.gsub(exp, expr, '%3'), " " );
      return oper[ op ]( eval( item, arg1, valueTab ), eval( item, arg2, valueTab )) ;
   end
   
   -- logical equals
   if (string.find(exp, '^(.+)==(.+)')) then
      local arg1 = strtrim( string.gsub(exp, '^(.+)==(.+)', '%1'), " " );
      local arg2 = strtrim( string.gsub(exp, '^(.+)==(.+)', '%2'), " " );
      return eval( item, arg1, valueTab ) == eval( item, arg2, valueTab ) ;
   end
   
   -- logical not equals
   if (string.find(exp, '^(.+)!=(.+)')) then
      local arg1 = strtrim( string.gsub(exp, '^(.+)!=(.+)', '%1'), " " );
      local arg2 = strtrim( string.gsub(exp, '^(.+)!=(.+)', '%2'), " " );
      return eval( item, arg1, valueTab ) ~= eval( item, arg2, valueTab ) ;
   end
   
   -- logical <=
   if (string.find(exp, '^(.+)<=(.+)')) then
      local arg1 = strtrim( string.gsub(exp, '^(.+)<=(.+)', '%1'), " " );
      local arg2 = strtrim( string.gsub(exp, '^(.+)<=(.+)', '%2'), " " );
      return eval( item, arg1, valueTab ) <= eval( item, arg2, valueTab ) ;
   end
   
   -- logical >=
   if (string.find(exp, '^(.+)>=(.+)')) then
      local arg1 = strtrim( string.gsub(exp, '^(.+)>=(.+)', '%1'), " " );
      local arg2 = strtrim( string.gsub(exp, '^(.+)>=(.+)', '%2'), " " );
      return eval( item, arg1, valueTab ) >= eval( item, arg2, valueTab ) ;
   end
   
   -- logical and, or, less than, greater than
   local expr = '^(.+)([<>])(.+)' ;
   if (string.find(exp, expr )) then
      local arg1 = strtrim( string.gsub(exp, expr, '%1'), " " );
      local op   = strtrim( string.gsub(exp, expr, '%2'), " " );
      local arg2 = strtrim( string.gsub(exp, expr, '%3'), " " );
      return oper[ op ]( eval( item, arg1, valueTab ), eval( item, arg2, valueTab )) ;
   end
   
   -- negate
   if string.find(exp, '^!(.+)') then
      local arg1 = strtrim( string.gsub(exp, '^!(.+)', '%1'), " " );
      return not eval( item, arg1, valueTab ) ;
   end
   
   if (string.find(exp, "^is%('(.+)'%)")) then
      local arg1 = strtrim( string.gsub(exp, "^is%('(.+)'%)", '%1'), " " );
      return isEquipLoc( item, arg1 ) ;
   end
   
   if (string.find(exp, "^isType%('(.+)'%)")) then
      local arg1 = strtrim( string.gsub(exp, "^isType%('(.+)'%)", '%1'), " " );
      return isType( item, arg1 ) ;
   end
   
   if (string.find(exp, "^isSubType%('(.+)'%)")) then
      local arg1 = strtrim( string.gsub(exp, "^isSubType%('(.+)'%)", '%1'), " " );
      return isSubType( item, arg1 ) ;
   end
   
   if (string.find(exp, "^level%((.+)-(.+)%)")) then
      local arg1 = strtrim( string.gsub(exp, "^level%((.+)-(.+)%)", '%1'), " " );
      local arg2 = strtrim( string.gsub(exp, "^level%((.+)-(.+)%)", '%2'), " " );
      return level( item, arg1, arg2 ) ;
   end
   
   if (string.find(exp, "^has%((.+)%)")) then
      local arg1 = strtrim( string.gsub(exp, "^has%((.+)%)", '%1'), " " );
      return hasStat( item, arg1 ) ;
   end
   
   if (string.find(exp, "^does%((.+)%)")) then
      local arg1 = strtrim( string.gsub(exp, "^does%((.+)%)", '%1'), " " );
      return statDoes( item, arg1 ) ;
   end
   
   -- literal
   local arg1 = exp ;
   local n = tonumber(arg1) ;
   
   if (n) then return n ; end
   if (arg1 == "nil") or (arg1 == "false") then return false ; end
   if (arg1 == "true") then return true ; end
   
   if (subst[arg1]) then
      return eval( item, subst[arg1], valueTab );
   end
   
   return arg1;    
end
-------------------------------------------------------------------------------

function Atr_NewQuery ()

  local query = {};
  setmetatable (query, AtrQuery);

  query.curPageInfo     = nil;
  query.prvPageInfo     = nil;
  query.numDupPages     = 0;
  _, query.totalAuctions    = -1;
  AtrQuery:dictionaryFilterReset() ;

  return query;
end

function AtrQuery:evaluateFilter( inventory, filter_text )
  if ((inventory == nil) or (inventory._info == nil) or (filter_text == nil)) then
    return 1 ; -- nominal ; nothing to disqualify or evaluate
  end
  if (string.find(filter_text, "#") == 1) then
    local rc = eval( inventory, string.sub( filter_text, 2, -1 ) ) ;
    if (rc) then return 2 ; end 
    return 0 ;
  end
  return 1 ; -- nominal acceptance
end

function AtrQuery:dictionaryFilterReset() 
  if (AtrQuery._dictionary) then
    for i,v in pairs(AtrQuery._dictionary) do
      v.filterValue = -1 ;
    end
  end
end 

-- checkSearchFilter
-- meant to evaluate the filter_text against the item in question and determine whether it passes
--
-- ie:  #20-23 & #one-hand & #axe | #sword | #mace
--
-- '0'   does not pass
-- '1'   nominal pass; likely no filter text setmetatable
-- '2'   fully passes
--
function AtrQuery:checkSearchFilter( inventory, filter_text ) 
  if (filter_text == nil) then
    return 1 ; -- '1' == nominal pass
  end
  -- make sure we have info on the item
  -- single time lookup
  -- note: potential memory issue depending on number of unique items on the
  --       AH and bytes per item (should be acceptable these days)
  --
  AtrQuery._dictionary = AtrQuery._dictionary or {} ; 
  if (AtrQuery._dictionary[ inventory.itemId ] == nil) then
    local info = {} ;
    info.itemName, 
    info.itemLink, 
    info.itemRarity, 
    info.itemLevel, 
    info.itemMinLevel, 
    info.itemType,
    info.itemSubType, 
    info.itemStackCount, 
    info.itemEquipLoc, 
    info.itemTexture, 
    info.itemSellPrice = GetItemInfo( inventory.itemId ) ;
    info.filterValue = -1 ;

    AtrQuery._dictionary[ inventory.itemId ] = info ;
  end
  if (inventory._info == nil) then
    inventory._info = AtrQuery._dictionary[ inventory.itemId ] ;
  end
--  inventory._info.filterValue = 
  local rc = AtrQuery:evaluateFilter( inventory, filter_text ) ;
  inventory._info.filterValue = rc ;
  return rc ;
end

-----------------------------------------
--
--  Capture the page info once so we don't have to make multiple calls to the Blizz API
--
function AtrQuery:CapturePageInfo( pagenum )
  self.curPageInfo = {}
  self.curPageInfo.pagenum = pagenum
  self.curPageInfo.auctionInfo  = {};

  self.curPageInfo.numOnPage, self.totalAuctions = Atr_GetNumAuctionItems("list");

  local auctionInfo = {};
  local x;

  local currentPane = Atr_GetCurrentPane()
  local filter_text = currentPane._originalSearchText or "" ;
  if (string.find( filter_text, ";" )) then
    filter_text = strsplit( ";", filter_text );
  end

  for x = 1, self.curPageInfo.numOnPage do
    auctionInfo = {};

    auctionInfo.name,
    auctionInfo.texture,
    auctionInfo.count,
    auctionInfo.quality,
    auctionInfo.canUse,
    auctionInfo.level,
    auctionInfo.huh,
    auctionInfo.minBid,
    auctionInfo.minIncrement,
    auctionInfo.buyoutPrice,
    auctionInfo.bidAmount,
    auctionInfo.highBidder,
    auctionInfo.bidderFullName,
    auctionInfo.owner,
    auctionInfo.ownerFullName, 
    auctionInfo.saleStatus,
    auctionInfo.itemId,
    auctionInfo.hasAllInfo    = GetAuctionItemInfo("list", x);
    auctionInfo.itemLink        = GetAuctionItemLink("list", x);
    auctionInfo.filterValue     = -1 ; -- not checked yet

    AtrQuery:checkSearchFilter( auctionInfo, filter_text ) ;
    self.curPageInfo.auctionInfo[x] = auctionInfo;
  end
end

-----------------------------------------

local function AuctionItemsAreDifferent( item1, item2 )
  return item1.name ~= item2.name or
    item1.count ~= item2.count or
    item1.minBid ~= item2.minBid or
    item1.buyoutPrice ~= item2.buyoutPrice or
    item1.bidAmount ~= item2.bidAmount
end

-----------------------------------------

function AtrQuery:CheckForDuplicatePage (pagenum)

  local x;
  local dupPageFound    = false;

  if (self.prvPageInfo) then
    if (self.prvPageInfo.numOnPage == self.curPageInfo.numOnPage) then

      local allItemsIdentical = true;

      dupPageFound = true;

      for x = 1, self.curPageInfo.numOnPage do

        if (allItemsIdentical and x > 1 and AuctionItemsAreDifferent (self.curPageInfo.auctionInfo[x], self.curPageInfo.auctionInfo[x-1])) then
          allItemsIdentical = false;
        end

        if (AuctionItemsAreDifferent (self.curPageInfo.auctionInfo[x], self.prvPageInfo.auctionInfo[x])) then
          dupPageFound = false
          break
        end

      end

      if (allItemsIdentical and dupPageFound) then    -- handle those numnuts who post 200 identical auctions
        zz ("ALL ITEMS IDENTICAL: ", self.prvPageInfo.pagenum, self.curPageInfo.pagenum);
        dupPageFound = false
      end
    end
  end

  if (dupPageFound) then
    self.numDupPages = self.numDupPages + 1
    zz ("DUPLICATE PAGE FOUND: ", self.prvPageInfo.pagenum, self.curPageInfo.pagenum);
  end

  self.prvPageInfo = {}

  zc.CopyDeep (self.prvPageInfo, self.curPageInfo);

  return dupPageFound

end


function AtrQuery:IsLastPage (pagenum)

  return (((pagenum + 1) * 50) >= self.totalAuctions);
end