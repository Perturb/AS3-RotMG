// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.death.control.HandleDeathSignal

package kabam.rotmg.death.control{
    import org.osflash.signals.Signal;
    import kabam.rotmg.messaging.impl.incoming.Death;

    public class HandleDeathSignal extends Signal {

        public function HandleDeathSignal(){
            super(Death);
        }

    }
}//package kabam.rotmg.death.control

