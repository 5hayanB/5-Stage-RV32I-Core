package Core

import chiseltest._
import org.scalatest._

class FiveStageCoreTest extends FreeSpec with ChiselScalatestTester
{
    "Five_Stage_Core" in
        {
            test(new FiveStageCore())
            {
                z =>
                    z.clock.step(100)
            }
        }
}
