// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.external.AdSenseGlobals

package com.google.analytics.external
{
    import com.google.analytics.debug.DebugConfiguration;

    public class AdSenseGlobals extends JavascriptProxy 
    {

        public static var gaGlobal_js:XML = <script>
            <![CDATA[
                function()
                {
                    try
                    {
                        gaGlobal
                    }
                    catch(e)
                    {
                        gaGlobal = {} ;
                    }
                }
            ]]>
        </script>
        ;

        private var _gaGlobalVerified:Boolean = false;

        public function AdSenseGlobals(_arg_1:DebugConfiguration)
        {
            super(_arg_1);
        }

        public function set vid(_arg_1:String):void
        {
            if (!isAvailable())
            {
                return;
            };
            _verify();
            setProperty("gaGlobal.vid", _arg_1);
        }

        public function get hid():String
        {
            if (!isAvailable())
            {
                return (null);
            };
            _verify();
            return (getProperty("gaGlobal.hid"));
        }

        public function set hid(_arg_1:String):void
        {
            if (!isAvailable())
            {
                return;
            };
            _verify();
            setProperty("gaGlobal.hid", _arg_1);
        }

        public function get dh():String
        {
            if (!isAvailable())
            {
                return (null);
            };
            _verify();
            return (getProperty("gaGlobal.dh"));
        }

        public function get sid():String
        {
            if (!isAvailable())
            {
                return (null);
            };
            _verify();
            return (getProperty("gaGlobal.sid"));
        }

        public function get vid():String
        {
            if (!isAvailable())
            {
                return (null);
            };
            _verify();
            return (getProperty("gaGlobal.vid"));
        }

        private function _verify():void
        {
            if (!_gaGlobalVerified)
            {
                executeBlock(gaGlobal_js);
                _gaGlobalVerified = true;
            };
        }

        public function set sid(_arg_1:String):void
        {
            if (!isAvailable())
            {
                return;
            };
            _verify();
            setProperty("gaGlobal.sid", _arg_1);
        }

        public function get gaGlobal():Object
        {
            if (!isAvailable())
            {
                return (null);
            };
            _verify();
            return (getProperty("gaGlobal"));
        }


    }
}//package com.google.analytics.external

