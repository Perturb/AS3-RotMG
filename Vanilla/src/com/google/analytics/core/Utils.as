// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.Utils

package com.google.analytics.core
{
    public class Utils 
    {


        public static function trim(_arg_1:String, _arg_2:Boolean=false):String
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            if (_arg_1 == "")
            {
                return ("");
            };
            var _local_3:Array = [" ", "\n", "\r", "\t"];
            var _local_4:String = _arg_1;
            if (_arg_2)
            {
                _local_5 = 0;
                while (((_local_5 < _local_3.length) && (_local_4.indexOf(_local_3[_local_5]) > -1)))
                {
                    _local_4 = _local_4.split(_local_3[_local_5]).join("");
                    _local_5++;
                };
            }
            else
            {
                _local_6 = 0;
                while (((_local_6 < _local_4.length) && (_local_3.indexOf(_local_4.charAt(_local_6)) > -1)))
                {
                    _local_6++;
                };
                _local_4 = _local_4.substr(_local_6);
                _local_7 = (_local_4.length - 1);
                while (((_local_7 >= 0) && (_local_3.indexOf(_local_4.charAt(_local_7)) > -1)))
                {
                    _local_7--;
                };
                _local_4 = _local_4.substring(0, (_local_7 + 1));
            };
            return (_local_4);
        }

        public static function generateHash(_arg_1:String):int
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:int = 1;
            var _local_3:int;
            if (((!(_arg_1 == null)) && (!(_arg_1 == ""))))
            {
                _local_2 = 0;
                _local_4 = (_arg_1.length - 1);
                while (_local_4 >= 0)
                {
                    _local_5 = _arg_1.charCodeAt(_local_4);
                    _local_2 = ((((_local_2 << 6) & 0x0FFFFFFF) + _local_5) + (_local_5 << 14));
                    _local_3 = (_local_2 & 0x0FE00000);
                    if (_local_3 != 0)
                    {
                        _local_2 = (_local_2 ^ (_local_3 >> 21));
                    };
                    _local_4--;
                };
            };
            return (_local_2);
        }

        public static function generate32bitRandom():int
        {
            return (Math.round((Math.random() * 2147483647)));
        }

        public static function validateAccount(_arg_1:String):Boolean
        {
            var _local_2:RegExp = /^UA-[0-9]*-[0-9]*$/;
            return (_local_2.test(_arg_1));
        }


    }
}//package com.google.analytics.core

