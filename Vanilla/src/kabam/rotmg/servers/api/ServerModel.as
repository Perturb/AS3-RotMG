// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.servers.api.ServerModel

package kabam.rotmg.servers.api
{
    import __AS3__.vec.Vector;

    public interface ServerModel 
    {

        function setServers(_arg_1:Vector.<Server>):void;
        function getServer():Server;
        function isServerAvailable():Boolean;
        function getServers():Vector.<Server>;

    }
}//package kabam.rotmg.servers.api

