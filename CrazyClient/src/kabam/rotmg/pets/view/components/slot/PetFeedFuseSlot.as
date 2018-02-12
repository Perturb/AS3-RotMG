// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.components.slot.PetFeedFuseSlot

package kabam.rotmg.pets.view.components.slot
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.pets.view.components.PetIconFactory;
    import flash.filters.ColorMatrixFilter;
    import com.company.util.MoreColorUtil;
    import flash.events.MouseEvent;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.pets.view.components.PetIcon;
    import kabam.rotmg.pets.data.PetVO;
    import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
    import kabam.rotmg.pets.data.PetFamilyKeys;
    import flash.geom.ColorTransform;

    public class PetFeedFuseSlot extends FeedFuseSlot 
    {

        public const openPetPicker:Signal = new Signal();

        public var showFamily:Boolean = false;
        public var processing:Boolean = false;
        private var petIconFactory:PetIconFactory = new PetIconFactory();
        private var grayscaleMatrix:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

        public function PetFeedFuseSlot()
        {
            addEventListener(MouseEvent.CLICK, this.onOpenPetPicker);
            this.updateTitle();
        }

        public function updateTitle():void
        {
            if (((!(icon)) || (contains(icon))))
            {
                setTitle(TextKey.PETORFOODSLOT_FUSE_PET_TITLE, {});
            };
        }

        private function onOpenPetPicker(_arg_1:MouseEvent):void
        {
            if (!this.processing)
            {
                this.openPetPicker.dispatch();
            };
        }

        public function setPetIcon(_arg_1:PetVO):void
        {
            var _local_2:PetIcon = this.petIconFactory.create(_arg_1, 48);
            setIcon(_local_2);
        }

        public function setPet(_arg_1:PetVO):void
        {
            var _local_2:AppendingLineBuilder;
            if (_arg_1)
            {
                this.setPetIcon(_arg_1);
                setTitle(TextKey.BLANK, {"data":_arg_1.getName()});
                _local_2 = new AppendingLineBuilder();
                _local_2.pushParams(_arg_1.getRarity());
                ((this.showFamily) && (_local_2.pushParams(PetFamilyKeys.getTranslationKey(_arg_1.getFamily()))));
                setSubtitle(TextKey.BLANK, {"data":_local_2});
            };
        }

        public function setProcessing(_arg_1:Boolean):void
        {
            var _local_2:ColorTransform;
            if (this.processing != _arg_1)
            {
                this.processing = _arg_1;
                icon.filters = ((_arg_1) ? [this.grayscaleMatrix] : []);
                _local_2 = ((_arg_1) ? MoreColorUtil.darkCT : new ColorTransform());
                icon.transform.colorTransform = _local_2;
            };
        }


    }
}//package kabam.rotmg.pets.view.components.slot

