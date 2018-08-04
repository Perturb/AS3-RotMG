// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.death.control.ResurrectPlayerSignal

package kabam.rotmg.death.control{
    import org.osflash.signals.Signal;
    import kabam.rotmg.messaging.impl.incoming.Death;

    public class ResurrectPlayerSignal extends Signal {

        public function ResurrectPlayerSignal(){
            super(Death);
        }

    }
}//package kabam.rotmg.death.control

