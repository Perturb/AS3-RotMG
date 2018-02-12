// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.X10

package com.google.analytics.data
{
    public class X10 
    {

        private var _delimEnd:String = ")";
        private var _minimum:int;
        private var _delimSet:String = "*";
        private var _escapeChar:String = "'";
        private var _delimBegin:String = "(";
        private var _delimNumValue:String = "!";
        private var _key:String = "k";
        private var _set:Array = [_key, _value];
        private var _hasData:int;
        private var _escapeCharMap:Object;
        private var _projectData:Object;
        private var _value:String = "v";

        public function X10()
        {
            _projectData = {};
            _escapeCharMap = {};
            _escapeCharMap[_escapeChar] = "'0";
            _escapeCharMap[_delimEnd] = "'1";
            _escapeCharMap[_delimSet] = "'2";
            _escapeCharMap[_delimNumValue] = "'3";
            _minimum = 1;
        }

        private function _setInternal(_arg_1:Number, _arg_2:String, _arg_3:Number, _arg_4:String):void
        {
            if (!hasProject(_arg_1))
            {
                _projectData[_arg_1] = {};
            };
            if (_projectData[_arg_1][_arg_2] == undefined)
            {
                _projectData[_arg_1][_arg_2] = [];
            };
            _projectData[_arg_1][_arg_2][_arg_3] = _arg_4;
            _hasData = (_hasData + 1);
        }

        private function _renderProject(_arg_1:Object):String
        {
            var _local_4:int;
            var _local_5:Array;
            var _local_2:* = "";
            var _local_3:Boolean;
            var _local_6:int = _set.length;
            _local_4 = 0;
            while (_local_4 < _local_6)
            {
                _local_5 = _arg_1[_set[_local_4]];
                if (_local_5)
                {
                    if (_local_3)
                    {
                        _local_2 = (_local_2 + _set[_local_4]);
                    };
                    _local_2 = (_local_2 + _renderDataType(_local_5));
                    _local_3 = false;
                }
                else
                {
                    _local_3 = true;
                };
                _local_4++;
            };
            return (_local_2);
        }

        public function hasProject(_arg_1:Number):Boolean
        {
            return (_projectData[_arg_1]);
        }

        public function clearKey(_arg_1:Number):void
        {
            _clearInternal(_arg_1, _key);
        }

        private function _renderDataType(_arg_1:Array):String
        {
            var _local_3:String;
            var _local_4:int;
            var _local_2:Array = [];
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                if (_arg_1[_local_4] != undefined)
                {
                    _local_3 = "";
                    if (((!(_local_4 == _minimum)) && (_arg_1[(_local_4 - 1)] == undefined)))
                    {
                        _local_3 = (_local_3 + _local_4.toString());
                        _local_3 = (_local_3 + _delimNumValue);
                    };
                    _local_3 = (_local_3 + _escapeExtensibleValue(_arg_1[_local_4]));
                    _local_2.push(_local_3);
                };
                _local_4++;
            };
            return ((_delimBegin + _local_2.join(_delimSet)) + _delimEnd);
        }

        public function getKey(_arg_1:Number, _arg_2:Number):String
        {
            return (_getInternal(_arg_1, _key, _arg_2) as String);
        }

        public function hasData():Boolean
        {
            return (_hasData > 0);
        }

        public function renderMergedUrlString(_arg_1:X10=null):String
        {
            var _local_3:String;
            if (!_arg_1)
            {
                return (renderUrlString());
            };
            var _local_2:Array = [_arg_1.renderUrlString()];
            for (_local_3 in _projectData)
            {
                if (((hasProject(Number(_local_3))) && (!(_arg_1.hasProject(Number(_local_3))))))
                {
                    _local_2.push((_local_3 + _renderProject(_projectData[_local_3])));
                };
            };
            return (_local_2.join(""));
        }

        public function setValue(_arg_1:Number, _arg_2:Number, _arg_3:Number):Boolean
        {
            if ((((!(Math.round(_arg_3) == _arg_3)) || (isNaN(_arg_3))) || (_arg_3 == Infinity)))
            {
                return (false);
            };
            _setInternal(_arg_1, _value, _arg_2, _arg_3.toString());
            return (true);
        }

        public function renderUrlString():String
        {
            var _local_2:String;
            var _local_1:Array = [];
            for (_local_2 in _projectData)
            {
                if (hasProject(Number(_local_2)))
                {
                    _local_1.push((_local_2 + _renderProject(_projectData[_local_2])));
                };
            };
            return (_local_1.join(""));
        }

        private function _getInternal(_arg_1:Number, _arg_2:String, _arg_3:Number):Object
        {
            if (((hasProject(_arg_1)) && (!(_projectData[_arg_1][_arg_2] == undefined))))
            {
                return (_projectData[_arg_1][_arg_2][_arg_3]);
            };
            return (undefined);
        }

        public function setKey(_arg_1:Number, _arg_2:Number, _arg_3:String):Boolean
        {
            _setInternal(_arg_1, _key, _arg_2, _arg_3);
            return (true);
        }

        public function clearValue(_arg_1:Number):void
        {
            _clearInternal(_arg_1, _value);
        }

        private function _clearInternal(_arg_1:Number, _arg_2:String):void
        {
            var _local_3:Boolean;
            var _local_4:int;
            var _local_5:int;
            if (((hasProject(_arg_1)) && (!(_projectData[_arg_1][_arg_2] == undefined))))
            {
                _projectData[_arg_1][_arg_2] = undefined;
                _local_3 = true;
                _local_5 = _set.length;
                _local_4 = 0;
                while (_local_4 < _local_5)
                {
                    if (_projectData[_arg_1][_set[_local_4]] != undefined)
                    {
                        _local_3 = false;
                        break;
                    };
                    _local_4++;
                };
                if (_local_3)
                {
                    _projectData[_arg_1] = undefined;
                    _hasData = (_hasData - 1);
                };
            };
        }

        public function getValue(_arg_1:Number, _arg_2:Number):*
        {
            var _local_3:* = _getInternal(_arg_1, _value, _arg_2);
            if (_local_3 == null)
            {
                return (null);
            };
            return (Number(_local_3));
        }

        private function _escapeExtensibleValue(_arg_1:String):String
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:String;
            var _local_2:* = "";
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1.charAt(_local_3);
                _local_5 = _escapeCharMap[_local_4];
                if (_local_5)
                {
                    _local_2 = (_local_2 + _local_5);
                }
                else
                {
                    _local_2 = (_local_2 + _local_4);
                };
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package com.google.analytics.data

