// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.controller.UpgradePetSignal

package kabam.rotmg.pets.controller
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.pets.data.IUpgradePetRequestVO;

    public class UpgradePetSignal extends Signal 
    {

        public function UpgradePetSignal()
        {
            super(IUpgradePetRequestVO);
        }

    }
}//package kabam.rotmg.pets.controller

