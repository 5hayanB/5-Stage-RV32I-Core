package Core

import chiseltest._
import org.scalatest._

class CoreTest extends FreeSpec with ChiselScalatestTester
{
    "Core" in
    {
        test(new Core())
        {
            z =>
                z.clock.step(100)
        }
    }
}
