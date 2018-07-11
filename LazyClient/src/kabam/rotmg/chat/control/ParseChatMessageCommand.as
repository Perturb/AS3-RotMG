// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.chat.control.ParseChatMessageCommand

package kabam.rotmg.chat.control
{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreObjectUtil;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.service.GoogleAnalytics;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.dialogs.model.PopupNamesConfig;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;

public class ParseChatMessageCommand
    {

        [Inject]
        public var data:String;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var addTextLine:AddTextLineSignal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var buildData:BuildData;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var tracking:GoogleAnalytics;

        private function pertCommands():Boolean
        {
            var _local_1:String = this.data.toLowerCase();
            var _local_2:Array;
            var _local_3:int;
            var _local_4:String;
            switch (_local_1)
            {
                case "/lf":
                case "/lockfilter":
                    Parameters.data_.lockFilter = !Parameters.data_.lockFilter;
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.lockFilter) ? ("Players hidden.") : ("Players shown.")), -2))
                    return true;
                case "/pf":
                case "/pets":
                case "/petfilter":
                    Parameters.data_.petFilter = !Parameters.data_.petFilter;
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.petFilter) ? ("Pets hidden.") : ("Pets shown.")), -2))
                    return true;
                case "/aimpriority":
                    _local_4 = "";
                    for each (_local_3 in Parameters.data_.autoAimPriority)
                    {
                        _local_4 = ((_local_4) + (_local_3) + ("(") + (ObjectLibrary.xmlLibrary_[_local_3].@id) + ("), "));
                    }
                    _local_4.slice(0, -2);
                    this.addTextLine.dispatch(ChatMessage.make("", ("Aim Priority List: [" + _local_4 + "]"), -2));
                    return true;
                case "/aimexception":
                    _local_4 = "";
                    for each (_local_3 in Parameters.data_.autoAimException)
                    {
                        _local_4 = ((_local_4) + (_local_3) + ("(") + (ObjectLibrary.xmlLibrary_[_local_3].@id) + ("), "));
                    }
                    _local_4.slice(0, -2);
                    this.addTextLine.dispatch(ChatMessage.make("", ("Aim Exception List: [" + _local_4 + "]"), -2));
                    return true;
                case "/aimignore":
                    _local_4 = "";
                    for each (_local_3 in Parameters.data_.autoAimIgnore)
                    {
                        _local_4 = ((_local_4) + (_local_3) + ("(") + (ObjectLibrary.xmlLibrary_[_local_3].@id) + ("), "));
                    }
                    _local_4.slice(0, -2);
                    this.addTextLine.dispatch(ChatMessage.make("", ("Aim Ignore List: [" + _local_4 + "]"), -2));
                    return true;
                case "/aiminvulnerable":
                    _local_4 = "";
                    for each (_local_3 in Parameters.data_.autoAimInvulnerable)
                    {
                        _local_4 = ((_local_4) + (_local_3) + ("(") + (ObjectLibrary.xmlLibrary_[_local_3].@id) + ("), "));
                    }
                    _local_4.slice(0, -2);
                    this.addTextLine.dispatch(ChatMessage.make("", ("Aim Invulnerable List: [" + _local_4 + "]"), -2));
                    return true;
                    /*
                    case "/adb":
                        this.addTextLine.dispatch(ChatMessage.make("", ("Average sync time: " + this.hudModel.gameSprite.map.player_.averageSyncTime + " ms."), -2));
                        return true;
                    */
                default:
                    _local_2 = _local_1.match("^/setpass (.+)$");
                    if (_local_2 != null) {
                        _local_2 = _local_1.match("^/setpass ([a-z0-9]+)$");
                        if (_local_2 != null) {
                            Parameters.data_.hacksPassword = _local_2[1];
                            Parameters.save();
                            this.addTextLine.dispatch(ChatMessage.make("", ("Your new password is: " + _local_2[1]), -2));
                        }
                        else {
                            this.addTextLine.dispatch(ChatMessage.make("", "Only numbers and letters are allowed in your password.", -2));
                        }
                        return true;
                    }
                    _local_2 = this.data.toLowerCase().match("^/autonex (\\d+)$");
                    if (_local_2 != null)
                    {
                        if (_local_2[1] > 100)
                        {
                            _local_2[1] = 100;
                        }
                        Parameters.data_.autoNexus = int(_local_2[1]);
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.autoNexus == 0) ? ("Autonexus disabled. Stay safe out there!") : ("Auto nexus set to " + Parameters.data_.autoNexus + "%")), -2));
                        return true;
                    }
                    _local_2 = _local_1.match("^/aimpriority (\\d+)$");
                    if (_local_2 != null)
                    {
                        if (ObjectLibrary.xmlLibrary_[_local_2[1]] == undefined)
                        {
                            this.addTextLine.dispatch(ChatMessage.make("", ("Undefined object ID: " + _local_2[1] + "."), -2));
                            return true;
                        }
                        _local_3 = Parameters.data_.autoAimPriority.indexOf(_local_2[1]);
                        if (_local_3 == -1)
                        {
                            Parameters.data_.autoAimPriority.push(_local_2[1]);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Added aim priority ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        else
                        {
                            Parameters.data_.autoAimPriority.splice(_local_3, 1);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Removed aim priority ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        Parameters.save();
                        return true;
                    }
                    _local_2 = _local_1.match("^/aimexception (\\d+)$");
                    if (_local_2 != null)
                    {
                        if (ObjectLibrary.xmlLibrary_[_local_2[1]] == undefined)
                        {
                            this.addTextLine.dispatch(ChatMessage.make("", ("Undefined object ID: " + _local_2[1] + "."), -2));
                            return true;
                        }
                        _local_3 = Parameters.data_.autoAimException.indexOf(_local_2[1]);
                        if (_local_3 == -1)
                        {
                            Parameters.data_.autoAimException.push(_local_2[1]);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Added aim exception ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        else
                        {
                            Parameters.data_.autoAimException.splice(_local_3, 1);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Removed aim exception ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        Parameters.save();
                        return true;
                    }
                    _local_2 = _local_1.match("^/aimignore (\\d+)$");
                    if (_local_2 != null)
                    {
                        if (ObjectLibrary.xmlLibrary_[_local_2[1]] == undefined)
                        {
                            this.addTextLine.dispatch(ChatMessage.make("", ("Undefined object ID: " + _local_2[1] + "."), -2));
                            return true;
                        }
                        _local_3 = Parameters.data_.autoAimIgnore.indexOf(_local_2[1]);
                        if (_local_3 == -1)
                        {
                            Parameters.data_.autoAimIgnore.push(_local_2[1]);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Added aim ignore ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        else
                        {
                            Parameters.data_.autoAimIgnore.splice(_local_3, 1);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Removed aim ignore ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        Parameters.save();
                        return true;
                    }
                    _local_2 = _local_1.match("^/aiminvulnerable (\\d+)$");
                    if (_local_2 != null)
                    {
                        if (ObjectLibrary.xmlLibrary_[_local_2[1]] == undefined)
                        {
                            this.addTextLine.dispatch(ChatMessage.make("", ("Undefined object ID: " + _local_2[1] + "."), -2));
                            return true;
                        }
                        _local_3 = Parameters.data_.autoAimInvulnerable.indexOf(_local_2[1]);
                        if (_local_3 == -1)
                        {
                            Parameters.data_.autoAimInvulnerable.push(_local_2[1]);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Added aim invulnerable ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        else
                        {
                            Parameters.data_.autoAimInvulnerable.splice(_local_3, 1);
                            this.addTextLine.dispatch(ChatMessage.make("", ("Removed aim invulnerable ID: " + _local_2[1] + " (" + ObjectLibrary.xmlLibrary_[_local_2[1]].@id + ")"), -2));
                        }
                        Parameters.save();
                        return true;
                    }
            }
            return false;
        }

        public function execute():void
        {
            var _local_1:Object;
            var _local_2:Object;
            var _local_3:uint;
            var _local_4:GameObject;
            var _local_5:String;
            var _local_6:String;
            if (Parameters.data_.showHacks)
            {
                if (pertCommands())
                {
                    return;
                }
            }
            switch (this.data)
            {
                case "/resetDailyQuests":
                    if (this.player.isAdmin())
                    {
                        _local_1 = {};
                        MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
                        this.client.sendRequest("/dailyquest/resetDailyQuests", _local_1);
                        this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Restarting daily quests. Please refresh game."));
                    }
                    return;
                case "/resetPackagePopup":
                    Parameters.data_[PopupNamesConfig.PACKAGES_OFFER_POPUP] = null;
                    return;
                case "/h":
                case "/help":
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
                    return;
                case "/c":
                case "/class":
                case "/classes":
                    _local_2 = {};
                    _local_3 = 0;
                    for each (_local_4 in this.hudModel.gameSprite.map.goDict_)
                    {
                        if (_local_4.props_.isPlayer_)
                        {
                            _local_2[_local_4.objectType_] = ((_local_2[_local_4.objectType_] != undefined) ? (_local_2[_local_4.objectType_] + 1) : uint(1));
                            _local_3++;
                        }
                    }
                    _local_5 = "";
                    for (_local_6 in _local_2)
                    {
                        _local_5 = (_local_5 + (((" " + ObjectLibrary.typeToDisplayId_[_local_6]) + ": ") + _local_2[_local_6]));
                    }
                    this.addTextLine.dispatch(ChatMessage.make("", ((("Classes online (" + _local_3) + "):") + _local_5)));
                    return;
                default:
                    this.hudModel.gameSprite.gsc_.playerText(this.data);
            }
        }


    }
}//package kabam.rotmg.chat.control

