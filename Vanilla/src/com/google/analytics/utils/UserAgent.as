// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.utils.UserAgent

package com.google.analytics.utils
{
    import flash.system.System;
    import com.google.analytics.core.Utils;
    import flash.system.Capabilities;

    public class UserAgent 
    {

        public static var minimal:Boolean = false;

        private var _localInfo:Environment;
        private var _applicationProduct:String;
        private var _version:Version;

        public function UserAgent(_arg_1:Environment, _arg_2:String="", _arg_3:String="")
        {
            _localInfo = _arg_1;
            applicationProduct = _arg_2;
            _version = Version.fromString(_arg_3);
        }

        public function get tamarinProductToken():String
        {
            if (UserAgent.minimal)
            {
                return ("");
            };
            if (System.vmVersion)
            {
                return ("Tamarin/" + Utils.trim(System.vmVersion, true));
            };
            return ("");
        }

        public function get applicationVersion():String
        {
            return (_version.toString(2));
        }

        public function get vendorProductToken():String
        {
            var _local_1:* = "";
            if (_localInfo.isAIR())
            {
                _local_1 = (_local_1 + "AIR");
            }
            else
            {
                _local_1 = (_local_1 + "FlashPlayer");
            };
            _local_1 = (_local_1 + "/");
            return (_local_1 + _version.toString(3));
        }

        public function toString():String
        {
            var _local_1:* = "";
            _local_1 = (_local_1 + applicationProductToken);
            if (applicationComment != "")
            {
                _local_1 = (_local_1 + (" " + applicationComment));
            };
            if (tamarinProductToken != "")
            {
                _local_1 = (_local_1 + (" " + tamarinProductToken));
            };
            if (vendorProductToken != "")
            {
                _local_1 = (_local_1 + (" " + vendorProductToken));
            };
            return (_local_1);
        }

        public function get applicationComment():String
        {
            var _local_1:Array = [];
            _local_1.push(_localInfo.platform);
            _local_1.push(_localInfo.playerType);
            if (!UserAgent.minimal)
            {
                _local_1.push(_localInfo.operatingSystem);
                _local_1.push(_localInfo.language);
            };
            if (Capabilities.isDebugger)
            {
                _local_1.push("DEBUG");
            };
            if (_local_1.length > 0)
            {
                return (("(" + _local_1.join("; ")) + ")");
            };
            return ("");
        }

        public function set applicationVersion(_arg_1:String):void
        {
            _version = Version.fromString(_arg_1);
        }

        public function get applicationProductToken():String
        {
            var _local_1:String = applicationProduct;
            if (applicationVersion != "")
            {
                _local_1 = (_local_1 + ("/" + applicationVersion));
            };
            return (_local_1);
        }

        public function set applicationProduct(_arg_1:String):void
        {
            _applicationProduct = _arg_1;
        }

        public function get applicationProduct():String
        {
            return (_applicationProduct);
        }


    }
}//package com.google.analytics.utils

