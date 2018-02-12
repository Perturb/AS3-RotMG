// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.Ecommerce

package com.google.analytics.core
{
    import com.google.analytics.debug.DebugConfiguration;
    import com.google.analytics.ecommerce.Transaction;

    public class Ecommerce 
    {

        private var _debug:DebugConfiguration;
        private var _trans:Array;

        public function Ecommerce(_arg_1:DebugConfiguration)
        {
            this._debug = _arg_1;
            _trans = new Array();
        }

        public function getTransLength():Number
        {
            return (_trans.length);
        }

        public function getTransFromArray(_arg_1:Number):Transaction
        {
            return (_trans[_arg_1]);
        }

        public function addTransaction(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:String, _arg_8:String):Transaction
        {
            var _local_9:Transaction;
            _local_9 = getTransaction(_arg_1);
            if (_local_9 == null)
            {
                _local_9 = new Transaction(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
                _trans.push(_local_9);
            }
            else
            {
                _local_9.affiliation = _arg_2;
                _local_9.total = _arg_3;
                _local_9.tax = _arg_4;
                _local_9.shipping = _arg_5;
                _local_9.city = _arg_6;
                _local_9.state = _arg_7;
                _local_9.country = _arg_8;
            };
            return (_local_9);
        }

        public function getTransaction(_arg_1:String):Transaction
        {
            var _local_2:Number;
            _local_2 = 0;
            while (_local_2 < _trans.length)
            {
                if (_trans[_local_2].id == _arg_1)
                {
                    return (_trans[_local_2]);
                };
                _local_2++;
            };
            return (null);
        }


    }
}//package com.google.analytics.core

