// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.parameters.Parameters

package com.company.assembleegameclient.parameters
{
import com.company.assembleegameclient.map.Map;
import com.company.util.KeyCodes;
import com.company.util.MoreDateUtil;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.net.SharedObject;
import flash.system.Capabilities;
import flash.utils.Dictionary;

public class Parameters
    {

        public static const BUILD_VERSION:String = "X27.0";
        public static const MINOR_VERSION:String = "1";
        public static const ENABLE_ENCRYPTION:Boolean = true;
        public static const PORT:int = 2050;
        public static const ALLOW_SCREENSHOT_MODE:Boolean = false;
        public static const USE_NEW_FRIENDS_UI:Boolean = true;
        public static const FELLOW_GUILD_COLOR:uint = 10944349;
        public static const NAME_CHOSEN_COLOR:uint = 0xFCDF00;
        public static var root:DisplayObject;
        public static const PLAYER_ROTATE_SPEED:Number = 0.003;
        public static const BREATH_THRESH:int = 20;
        public static const SERVER_CHAT_NAME:String = "";
        public static const CLIENT_CHAT_NAME:String = "*Client*";
        public static const ERROR_CHAT_NAME:String = "*Error*";
        public static const HELP_CHAT_NAME:String = "*Help*";
        public static const GUILD_CHAT_NAME:String = "*Guild*";
        public static const TYPE:String = "Lazy";
        public static const NEWS_TIMESTAMP_DEFAULT:Number = 1.1;
        public static const NAME_CHANGE_PRICE:int = 1000;
        public static const GUILD_CREATION_PRICE:int = 1000;
        public static var data_:Object = null;
        public static var GPURenderError:Boolean = false;
        public static var sessionStarted:Boolean = false;
        public static var blendType_:int = 1;
        public static var projColorType_:int = 0;
        public static var drawProj_:Boolean = true;
        public static var screenShotMode_:Boolean = false;
        public static var screenShotSlimMode_:Boolean = false;
        public static var sendLogin_:Boolean = true;
        public static const TUTORIAL_GAMEID:int = -1;
        public static const NEXUS_GAMEID:int = -2;
        public static const RANDOM_REALM_GAMEID:int = -3;
        public static const MAPTEST_GAMEID:int = -6;
        public static const MAX_SINK_LEVEL:Number = 18;
        public static const TERMS_OF_USE_URL:String = "http://legal.decagames.com/tos/";
        public static const PRIVACY_POLICY_URL:String = "http://legal.decagames.com/privacy/";
        public static const USER_GENERATED_CONTENT_TERMS:String = "/UGDTermsofUse.html";
        public static const RANDOM1:String = "311f80691451c71b09a13a2a6e";
        public static const RANDOM2:String = "72c5583cafb6818995cbd74b80";
        public static const RSA_PUBLIC_KEY:String = ((((("-----BEGIN PUBLIC KEY-----\n" + "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCKFctVrhfF3m2Kes0FBL/JFeO") + "cmNg9eJz8k/hQy1kadD+XFUpluRqa//Uxp2s9W2qE0EoUCu59ugcf/p7lGuL99Uo") + "SGmQEynkBvZct+/M40L0E0rZ4BVgzLOJmIbXMp0J4PnPcb6VLZvxazGcmSfjauC7") + "F3yWYqUbZd/HCBtawwIDAQAB\n") + "-----END PUBLIC KEY-----");
        private static var savedOptions_:SharedObject = null;
        public static const skinTypes16:Vector.<int> = new <int>[1027, 0x0404, 1029, 1030, 10973, 19494, 19531, 6346];
        public static const itemTypes16:Vector.<int> = new <int>[5473, 5474, 5475, 5476, 10939, 19494, 19531, 6347];
        private static var keyNames_:Dictionary = new Dictionary();


        public static function load():void
        {
            try
            {
                savedOptions_ = SharedObject.getLocal("AssembleeGameClientOptions", "/");
                data_ = savedOptions_.data;
            }
            catch(error:Error)
            {
                data_ = {};
            }
            setDefaults();
            save();
        }

        public static function save():void
        {
            try
            {
                if (savedOptions_ != null)
                {
                    savedOptions_.flush();
                }
            }
            catch(error:Error)
            {
            }
        }

        private static function setDefaultKey(_arg_1:String, _arg_2:uint):void
        {
            if (!data_.hasOwnProperty(_arg_1))
            {
                data_[_arg_1] = _arg_2;
            }
            keyNames_[_arg_1] = true;
        }

        public static function setKey(_arg_1:String, _arg_2:uint):void
        {
            var _local_3:String;
            for (_local_3 in keyNames_)
            {
                if (data_[_local_3] == _arg_2)
                {
                    data_[_local_3] = KeyCodes.UNSET;
                }
            }
            data_[_arg_1] = _arg_2;
        }

        private static function setDefault(_arg_1:String, _arg_2:*):void
        {
            if (!data_.hasOwnProperty(_arg_1))
            {
                data_[_arg_1] = _arg_2;
            }
        }

        public static function isGpuRender():Boolean
        {
            return (((!(GPURenderError)) && (data_.GPURender)) && (!(Map.forceSoftwareRender)));
        }

        public static function clearGpuRenderEvent(_arg_1:Event):void
        {
            clearGpuRender();
        }

        public static function clearGpuRender():void
        {
            GPURenderError = true;
        }

        public static function setDefaults():void
        {
            setDefaultKey("moveLeft", KeyCodes.A);
            setDefaultKey("moveRight", KeyCodes.D);
            setDefaultKey("moveUp", KeyCodes.W);
            setDefaultKey("moveDown", KeyCodes.S);
            setDefaultKey("rotateLeft", KeyCodes.Q);
            setDefaultKey("rotateRight", KeyCodes.E);
            setDefaultKey("useSpecial", KeyCodes.SPACE);
            setDefaultKey("interact", KeyCodes.NUMBER_0);
            setDefaultKey("useInvSlot1", KeyCodes.NUMBER_1);
            setDefaultKey("useInvSlot2", KeyCodes.NUMBER_2);
            setDefaultKey("useInvSlot3", KeyCodes.NUMBER_3);
            setDefaultKey("useInvSlot4", KeyCodes.NUMBER_4);
            setDefaultKey("useInvSlot5", KeyCodes.NUMBER_5);
            setDefaultKey("useInvSlot6", KeyCodes.NUMBER_6);
            setDefaultKey("useInvSlot7", KeyCodes.NUMBER_7);
            setDefaultKey("useInvSlot8", KeyCodes.NUMBER_8);
            setDefaultKey("escapeToNexus2", KeyCodes.F5);
            setDefaultKey("escapeToNexus", KeyCodes.R);
            setDefaultKey("autofireToggle", KeyCodes.I);
            setDefaultKey("scrollChatUp", KeyCodes.PAGE_UP);
            setDefaultKey("scrollChatDown", KeyCodes.PAGE_DOWN);
            setDefaultKey("miniMapZoomOut", KeyCodes.MINUS);
            setDefaultKey("miniMapZoomIn", KeyCodes.EQUAL);
            setDefaultKey("resetToDefaultCameraAngle", KeyCodes.Z);
            setDefaultKey("togglePerformanceStats", KeyCodes.UNSET);
            setDefaultKey("options", KeyCodes.O);
            setDefaultKey("toggleCentering", KeyCodes.X);
            setDefaultKey("chat", KeyCodes.ENTER);
            setDefaultKey("chatCommand", KeyCodes.SLASH);
            setDefaultKey("tell", KeyCodes.TAB);
            setDefaultKey("guildChat", KeyCodes.G);
            setDefaultKey("testOne", KeyCodes.PERIOD);
            setDefaultKey("toggleFullscreen", KeyCodes.UNSET);
            setDefaultKey("useHealthPotion", KeyCodes.F);
            setDefaultKey("GPURenderToggle", KeyCodes.UNSET);
            setDefaultKey("friendList", KeyCodes.UNSET);
            setDefaultKey("useMagicPotion", KeyCodes.V);
            setDefaultKey("switchTabs", KeyCodes.B);
            setDefaultKey("particleEffect", KeyCodes.P);
            setDefaultKey("toggleHPBar", KeyCodes.H);
            setDefaultKey("toggleProjectiles", KeyCodes.N);
            setDefaultKey("toggleMasterParticles", KeyCodes.M);
            setDefault("playerObjectType", 782);
            setDefault("playMusic", true);
            setDefault("playSFX", true);
            setDefault("playPewPew", true);
            setDefault("centerOnPlayer", true);
            setDefault("preferredServer", null);
            setDefault("bestServer", null);
            setDefault("needsTutorial", true);
            setDefault("needsRandomRealm", true);
            setDefault("cameraAngle", 0);
            setDefault("defaultCameraAngle", 0);
            setDefault("showQuestPortraits", true);
            setDefault("fullscreenMode", false);
            setDefault("showProtips", true);
            setDefault("protipIndex", 0);
            setDefault("joinDate", MoreDateUtil.getDayStringInPT());
            setDefault("lastDailyAnalytics", null);
            setDefault("allowRotation", true);
            setDefault("allowMiniMapRotation", false);
            setDefault("charIdUseMap", {});
            setDefault("drawShadows", true);
            setDefault("textBubbles", true);
            setDefault("showTradePopup", true);
            setDefault("paymentMethod", null);
            setDefault("filterLanguage", true);
            setDefault("showGuildInvitePopup", true);
            setDefault("showBeginnersOffer", false);
            setDefault("beginnersOfferTimeLeft", 0);
            setDefault("beginnersOfferShowNow", false);
            setDefault("beginnersOfferShowNowTime", 0);
            setDefault("watchForTutorialExit", false);
            setDefault("clickForGold", false);
            setDefault("contextualPotionBuy", false);
            setDefault("inventorySwap", true);
            setDefault("particleEffect", false);
            setDefault("uiQuality", true);
            setDefault("disableEnemyParticles", false);
            setDefault("disableAllyShoot", 0);
            setDefault("disablePlayersHitParticles", false);
            setDefault("cursorSelect", "4");
            if (Capabilities.playerType == "Desktop")
            {
                setDefault("GPURender", false);
            }
            else
            {
                setDefault("GPURender", false);
            }
            setDefault("forceChatQuality", false);
            setDefault("hidePlayerChat", false);
            setDefault("chatStarRequirement", 2);
            setDefault("chatAll", true);
            setDefault("chatWhisper", true);
            setDefault("chatGuild", true);
            setDefault("chatTrade", true);
            setDefault("toggleBarText", 0);
            setDefault("toggleToMaxText", false);
            setDefault("particleEffect", true);
            if (((data_.hasOwnProperty("playMusic")) && (data_.playMusic == true)))
            {
                setDefault("musicVolume", 1);
            }
            else
            {
                setDefault("musicVolume", 0);
            }
            if (((data_.hasOwnProperty("playSFX")) && (data_.playMusic == true)))
            {
                setDefault("SFXVolume", 1);
            }
            else
            {
                setDefault("SFXVolume", 0);
            }
            setDefault("friendList", KeyCodes.UNSET);
            setDefault("tradeWithFriends", false);
            setDefault("chatFriend", false);
            setDefault("friendStarRequirement", 0);
            setDefault("HPBar", 1);
            setDefault("newMiniMapColors", false);
            setDefault("noParticlesMaster", false);
            setDefault("noAllyNotifications", false);
            setDefault("noAllyDamage", false);
            setDefault("noEnemyDamage", false);
            setDefault("forceEXP", 0);
            setDefault("showFameGain", false);
            setDefault("curseIndication", false);
            setDefault("showTierTag", true);
            setDefault("showHacks", false);
            setDefault("unsafeHackKeys", false);
            setDefault("hacksPassword", "mpgh");
            setDefault("autoNexus", 15);
            setDefault("autoNexusDebug", false);
            setDefault("connectCommand", "/con");
            setDefault("noConfuse", false);
            setDefault("confuseRecoveryMinMS", 10);
            setDefault("noBlind", false);
            setDefault("noDrunk", false);
            setDefault("noDarkness", false);
            setDefault("noHallucinate", false);
            setDefault("noUnstableAbility", false);
            setDefault("lockFilter", false);
            setDefault("petFilter", false);
            setDefaultKey("autoAimToggle", KeyCodes.UNSET);
            setDefault("autoAim", false);
            setDefault("autoAimExtraRange", .5);
            setDefault("autoAimPriority", [29535, 29518, 29054, 5952, 29308, 29309, 29550, 29551, 29258, 29259, 29260, 29261, 29262, 6282, 1646, 3472, 3408]);
            setDefault("autoAimException", [355, 373, 374, 375, 376, 3463, 2053, 2052, 3461, 3414, 3417, 3441, 3561, 3448, 3449, 3472, 3334, 5952, 2354, 2369, 3368, 3366, 3367, 3391, 3389, 3390, 5920, 2314, 3412, 3639, 3634, 2327, 1755, 24582, 24351, 24363, 24135, 24133, 24134, 24132, 24136, 3356, 3357, 3358, 3359, 3360, 3361, 3362, 3363, 3364, 2352, 28780, 28781, 28795, 28942, 28957, 28988, 28938, 29291, 29018, 29517, 24338, 29580, 29712, 6282, 29054, 29308, 29309, 29550, 29551, 29258, 29259, 29260, 29261, 29262]);
            setDefault("autoAimIgnore", [1711, 1712, 1550, 1551, 1552, 1619, 1715, 2309, 2310, 2311, 2371, 2312, 0x0909, 2370, 2392, 2393, 2400, 2401, 3335, 3336, 3337, 3338, 3413, 3418, 3419, 3420, 3421, 3427, 3454, 3638, 3645, 6157, 28715, 28716, 28717, 28718, 28719, 28730, 28731, 28732, 28733, 28734, 29306, 29568, 29594, 29597, 29710, 29711, 29742, 29743, 29746, 29748, 30001, 29752, 43702, 43708, 43709, 43710, 3389, 3390, 3391, 0x0900, 2305, 2306, 0x0600, 1537, 1538, 1539, 1540]);
            setDefault("autoAimInvulverable", []);
            setDefault("autoAimCheckCollisions", true);
            setDefault("autoAimLead", true);
            setDefault("autoAimShoot", true);
            setDefault("autoAimReactionMinMS", 10);
            setDefault("showEnemyID", false);
            setDefault("quickSwap", false);
            setDefault("vaultOnNewGame", false);

            if (!data_.hasOwnProperty("needsSurvey"))
            {
                data_.needsSurvey = data_.needsTutorial;
                switch (int((Math.random() * 5)))
                {
                    case 0:
                        data_.surveyDate = 0;
                        data_.playTimeLeftTillSurvey = (5 * 60);
                        data_.surveyGroup = "5MinPlaytime";
                        return;
                    case 1:
                        data_.surveyDate = 0;
                        data_.playTimeLeftTillSurvey = (10 * 60);
                        data_.surveyGroup = "10MinPlaytime";
                        return;
                    case 2:
                        data_.surveyDate = 0;
                        data_.playTimeLeftTillSurvey = (30 * 60);
                        data_.surveyGroup = "30MinPlaytime";
                        return;
                    case 3:
                        data_.surveyDate = (new Date().time + ((((1000 * 60) * 60) * 24) * 7));
                        data_.playTimeLeftTillSurvey = (2 * 60);
                        data_.surveyGroup = "1WeekRealtime";
                        return;
                    case 4:
                        data_.surveyDate = (new Date().time + ((((1000 * 60) * 60) * 24) * 14));
                        data_.playTimeLeftTillSurvey = (2 * 60);
                        data_.surveyGroup = "2WeekRealtime";
                        return;
                }
            }
        }


    }
}//package com.company.assembleegameclient.parameters

