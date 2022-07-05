package FiveStageCore

import chiseltest._
import org.scalatest._

class FiveStageCoreTest extends FreeSpec with ChiselScalatestTester
{
    "FiveStageCore" in
    {
        test(new FiveStageCore())
        {
            z => z.clock.step(100)
        }
    }
}
