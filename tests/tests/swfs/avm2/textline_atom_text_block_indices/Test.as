package {
    import flash.display.Sprite;
    import flash.text.engine.ElementFormat;
    import flash.text.engine.TextBlock;
    import flash.text.engine.TextElement;
    import flash.text.engine.TextLine;

    public class Test extends Sprite {
        public function Test() {
            var block:TextBlock = new TextBlock(new TextElement("ab\ncd", new ElementFormat()));
            var first:TextLine = block.createTextLine(null, 10000);
            var second:TextLine = block.createTextLine(first, 10000);

            traceAtoms(first);
            traceAtoms(second);

            checkRange(first, -1);
            checkRange(second, second.atomCount);
        }

        private function traceAtoms(line:TextLine):void {
            for (var i:int = 0; i < line.atomCount; i++) {
                trace(line.getAtomTextBlockBeginIndex(i) + ".." + line.getAtomTextBlockEndIndex(i));
            }
        }

        private function checkRange(line:TextLine, index:int):void {
            try {
                line.getAtomTextBlockBeginIndex(index);
                trace("begin accepted invalid atom");
            } catch (e:RangeError) {
                trace("begin rejected invalid atom");
            }
            try {
                line.getAtomTextBlockEndIndex(index);
                trace("end accepted invalid atom");
            } catch (e:RangeError) {
                trace("end rejected invalid atom");
            }
        }
    }
}
