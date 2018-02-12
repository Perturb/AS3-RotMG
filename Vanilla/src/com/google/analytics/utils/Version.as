// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.utils.Version

package com.google.analytics.utils
{
    public class Version 
    {

        private var _revision:uint;
        private var _maxBuild:uint = 0xFF;
        private var _maxMinor:uint = 15;
        private var _maxMajor:uint = 15;
        private var _separator:String = ".";
        private var _maxRevision:uint = 0xFFFF;
        private var _build:uint;
        private var _major:uint;
        private var _minor:uint;

        public function Version(_arg_1:uint=0, _arg_2:uint=0, _arg_3:uint=0, _arg_4:uint=0)
        {
            var _local_5:Version;
            super();
            if (((((_arg_1 > _maxMajor) && (_arg_2 == 0)) && (_arg_3 == 0)) && (_arg_4 == 0)))
            {
                _local_5 = Version.fromNumber(_arg_1);
                _arg_1 = _local_5.major;
                _arg_2 = _local_5.minor;
                _arg_3 = _local_5.build;
                _arg_4 = _local_5.revision;
            };
            this.major = _arg_1;
            this.minor = _arg_2;
            this.build = _arg_3;
            this.revision = _arg_4;
        }

        public static function fromString(_arg_1:String="", _arg_2:String="."):Version
        {
            var _local_4:Array;
            var _local_3:Version = new (Version)();
            if (((_arg_1 == "") || (_arg_1 == null)))
            {
                return (_local_3);
            };
            if (_arg_1.indexOf(_arg_2) > -1)
            {
                _local_4 = _arg_1.split(_arg_2);
                _local_3.major = parseInt(_local_4[0]);
                _local_3.minor = parseInt(_local_4[1]);
                _local_3.build = parseInt(_local_4[2]);
                _local_3.revision = parseInt(_local_4[3]);
            }
            else
            {
                _local_3.major = parseInt(_arg_1);
            };
            return (_local_3);
        }

        public static function fromNumber(_arg_1:Number=0):Version
        {
            var _local_2:Version = new (Version)();
            if (((((((isNaN(_arg_1)) || (_arg_1 == 0)) || (_arg_1 < 0)) || (_arg_1 == Number.MAX_VALUE)) || (_arg_1 == Number.POSITIVE_INFINITY)) || (_arg_1 == Number.NEGATIVE_INFINITY)))
            {
                return (_local_2);
            };
            _local_2.major = (_arg_1 >>> 28);
            _local_2.minor = ((_arg_1 & 0x0F000000) >>> 24);
            _local_2.build = ((_arg_1 & 0xFF0000) >>> 16);
            _local_2.revision = (_arg_1 & 0xFFFF);
            return (_local_2);
        }


        public function toString(_arg_1:int=0):String
        {
            var _local_2:Array;
            if (((_arg_1 <= 0) || (_arg_1 > 4)))
            {
                _arg_1 = getFields();
            };
            switch (_arg_1)
            {
                case 1:
                    _local_2 = [major];
                    break;
                case 2:
                    _local_2 = [major, minor];
                    break;
                case 3:
                    _local_2 = [major, minor, build];
                    break;
                case 4:
                default:
                    _local_2 = [major, minor, build, revision];
            };
            return (_local_2.join(_separator));
        }

        public function set revision(_arg_1:uint):void
        {
            _revision = Math.min(_arg_1, _maxRevision);
        }

        public function get revision():uint
        {
            return (_revision);
        }

        public function set build(_arg_1:uint):void
        {
            _build = Math.min(_arg_1, _maxBuild);
        }

        public function set minor(_arg_1:uint):void
        {
            _minor = Math.min(_arg_1, _maxMinor);
        }

        public function get build():uint
        {
            return (_build);
        }

        public function set major(_arg_1:uint):void
        {
            _major = Math.min(_arg_1, _maxMajor);
        }

        public function get minor():uint
        {
            return (_minor);
        }

        private function getFields():int
        {
            var _local_1:int = 4;
            if (revision == 0)
            {
                _local_1--;
            };
            if (((_local_1 == 3) && (build == 0)))
            {
                _local_1--;
            };
            if (((_local_1 == 2) && (minor == 0)))
            {
                _local_1--;
            };
            return (_local_1);
        }

        public function valueOf():uint
        {
            return ((((major << 28) | (minor << 24)) | (build << 16)) | revision);
        }

        public function get major():uint
        {
            return (_major);
        }

        public function equals(_arg_1:*):Boolean
        {
            if (!(_arg_1 is Version))
            {
                return (false);
            };
            if (((((_arg_1.major == major) && (_arg_1.minor == minor)) && (_arg_1.build == build)) && (_arg_1.revision == revision)))
            {
                return (true);
            };
            return (false);
        }


    }
}//package com.google.analytics.utils

