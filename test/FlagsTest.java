import menu.*;
import org.junit.*;

/**
 * Class made for testing the dishes' filters
 */

public class FlagsTest {

    private MenuElement starter = new MenuElement("Bruschetta","S001", DishType.STARTER,
            4.00, true, true, false);
    private MenuElement first = new MenuElement("Spaghetti alla carbonara", "P001",
            DishType.FIRST_COURSE,10.0, false, false, false);
    private MenuElement celiac = new MenuElement("Pizza Camut", "S003", DishType.MAIN_COURSE, 5.0, false, true, true);

    /**
     * These methods test the method respecFilters of class MenuElement
     * and indirectly also method check of class Flags.
     */
    @Test
    public void veganTest() {
        Assert.assertTrue(starter.respectsFilters(true, false, false));
        Assert.assertFalse(first.respectsFilters(true, false, false));
        Assert.assertFalse(celiac.respectsFilters(true, false, false));
    }

    @Test
    public void veggieTest() {
        Assert.assertTrue(starter.respectsFilters(false, true, false));
        Assert.assertFalse(first.respectsFilters(false, true, false));
        Assert.assertTrue(celiac.respectsFilters(false, true, false));
    }

    @Test
    public void celiacTest() {
        Assert.assertFalse(starter.respectsFilters(false, false, true));
        Assert.assertFalse(first.respectsFilters(false, false, true));
        Assert.assertTrue(celiac.respectsFilters(false, false, true));

    }

    @Test
    public void vegVegTest() {
        Assert.assertTrue(starter.respectsFilters(true, true, false));
        Assert.assertFalse(first.respectsFilters(true, true, false));
        Assert.assertFalse(celiac.respectsFilters(true, true, false));
    }
}
