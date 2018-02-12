// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.Organic

package com.google.analytics.core
{
    import com.google.analytics.utils.Variables;

    public class Organic 
    {

        public static var throwErrors:Boolean = false;

        private var _sourcesCache:Array;
        private var _sourcesEngine:Array;
        private var _ignoredKeywords:Array;
        private var _ignoredReferralsCache:Object;
        private var _ignoredReferrals:Array;
        private var _ignoredKeywordsCache:Object;
        private var _sources:Array;

        public function Organic()
        {
            _sources = [];
            _sourcesCache = [];
            _sourcesEngine = [];
            _ignoredReferrals = [];
            _ignoredReferralsCache = {};
            _ignoredKeywords = [];
            _ignoredKeywordsCache = {};
        }

        public static function getKeywordValueFromPath(_arg_1:String, _arg_2:String):String
        {
            var _local_3:String;
            var _local_4:Variables;
            if (_arg_2.indexOf((_arg_1 + "=")) > -1)
            {
                if (_arg_2.charAt(0) == "?")
                {
                    _arg_2 = _arg_2.substr(1);
                };
                _arg_2 = _arg_2.split("+").join("%20");
                _local_4 = new Variables(_arg_2);
                _local_3 = _local_4[_arg_1];
            };
            return (_local_3);
        }


        public function isIgnoredKeyword(_arg_1:String):Boolean
        {
            if (_ignoredKeywordsCache.hasOwnProperty(_arg_1))
            {
                return (true);
            };
            return (false);
        }

        public function getKeywordValue(_arg_1:OrganicReferrer, _arg_2:String):String
        {
            var _local_3:String = _arg_1.keyword;
            return (getKeywordValueFromPath(_local_3, _arg_2));
        }

        public function isIgnoredReferral(_arg_1:String):Boolean
        {
            if (_ignoredReferralsCache.hasOwnProperty(_arg_1))
            {
                return (true);
            };
            return (false);
        }

        public function clear():void
        {
            clearEngines();
            clearIgnoredReferrals();
            clearIgnoredKeywords();
        }

        public function get count():int
        {
            return (_sources.length);
        }

        public function get ignoredKeywordsCount():int
        {
            return (_ignoredKeywords.length);
        }

        public function match(_arg_1:String):Boolean
        {
            if (_arg_1 == "")
            {
                return (false);
            };
            _arg_1 = _arg_1.toLowerCase();
            if (_sourcesEngine[_arg_1] != undefined)
            {
                return (true);
            };
            return (false);
        }

        public function clearIgnoredKeywords():void
        {
            _ignoredKeywords = [];
            _ignoredKeywordsCache = {};
        }

        public function addSource(_arg_1:String, _arg_2:String):void
        {
            var _local_3:OrganicReferrer = new OrganicReferrer(_arg_1, _arg_2);
            if (_sourcesCache[_local_3.toString()] == undefined)
            {
                _sources.push(_local_3);
                _sourcesCache[_local_3.toString()] = (_sources.length - 1);
                if (_sourcesEngine[_local_3.engine] == undefined)
                {
                    _sourcesEngine[_local_3.engine] = [(_sources.length - 1)];
                }
                else
                {
                    _sourcesEngine[_local_3.engine].push((_sources.length - 1));
                };
            }
            else
            {
                if (throwErrors)
                {
                    throw (new Error((_local_3.toString() + " already exists, we don't add it.")));
                };
            };
        }

        public function clearEngines():void
        {
            _sources = [];
            _sourcesCache = [];
            _sourcesEngine = [];
        }

        public function get ignoredReferralsCount():int
        {
            return (_ignoredReferrals.length);
        }

        public function addIgnoredReferral(_arg_1:String):void
        {
            if (_ignoredReferralsCache[_arg_1] == undefined)
            {
                _ignoredReferrals.push(_arg_1);
                _ignoredReferralsCache[_arg_1] = (_ignoredReferrals.length - 1);
            }
            else
            {
                if (throwErrors)
                {
                    throw (new Error((('"' + _arg_1) + "\" already exists, we don't add it.")));
                };
            };
        }

        public function clearIgnoredReferrals():void
        {
            _ignoredReferrals = [];
            _ignoredReferralsCache = {};
        }

        public function getReferrerByName(_arg_1:String):OrganicReferrer
        {
            var _local_2:int;
            if (match(_arg_1))
            {
                _local_2 = _sourcesEngine[_arg_1][0];
                return (_sources[_local_2]);
            };
            return (null);
        }

        public function addIgnoredKeyword(_arg_1:String):void
        {
            if (_ignoredKeywordsCache[_arg_1] == undefined)
            {
                _ignoredKeywords.push(_arg_1);
                _ignoredKeywordsCache[_arg_1] = (_ignoredKeywords.length - 1);
            }
            else
            {
                if (throwErrors)
                {
                    throw (new Error((('"' + _arg_1) + "\" already exists, we don't add it.")));
                };
            };
        }

        public function get sources():Array
        {
            return (_sources);
        }


    }
}//package com.google.analytics.core

