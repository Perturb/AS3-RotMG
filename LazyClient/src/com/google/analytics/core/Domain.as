// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.Domain

package com.google.analytics.core
{
    import com.google.analytics.debug.DebugConfiguration;
    import com.google.analytics.debug.VisualDebugMode;

    public class Domain 
    {

        private var _mode:DomainNameMode;
        private var _debug:DebugConfiguration;
        private var _name:String;

        public function Domain(_arg_1:DomainNameMode=null, _arg_2:String="", _arg_3:DebugConfiguration=null)
        {
            _debug = _arg_3;
            if (_arg_1 == null)
            {
                _arg_1 = DomainNameMode.auto;
            };
            _mode = _arg_1;
            if (_arg_1 == DomainNameMode.custom)
            {
                this.name = _arg_2;
            }
            else
            {
                _name = _arg_2;
            };
        }

        public function get mode():DomainNameMode
        {
            return (_mode);
        }

        public function set mode(_arg_1:DomainNameMode):void
        {
            _mode = _arg_1;
            if (_mode == DomainNameMode.none)
            {
                _name = "";
            };
        }

        public function get name():String
        {
            return (_name);
        }

        public function set name(_arg_1:String):void
        {
            if (((!(_arg_1.charAt(0) == ".")) && (_debug)))
            {
                _debug.warning(('missing leading period ".", cookie will only be accessible on ' + _arg_1), VisualDebugMode.geek);
            };
            _name = _arg_1;
        }


    }
}//package com.google.analytics.core

