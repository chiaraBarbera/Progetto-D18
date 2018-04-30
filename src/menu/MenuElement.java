package menu;

import java.util.ArrayList;

public class MenuElement {
    private String name, elementCode;
    private DishType type;
    private double price;
    private ArrayList<Allergen> allergenList;
    private ArrayList<String> ingredientsList ;

    public MenuElement(String name, String elementCode, DishType type, double price) {
        this.name = name;
        this.elementCode = elementCode;
        this.type = type;
        this.price = price;
        allergenList = new ArrayList<>();
        ingredientsList = new ArrayList<>() ;
    }

    public String getName() {
        return name;
    }

    public String getElementCode() {
        return elementCode;
    }

    public double getPrice() {
        return price;
    }

    public DishType getType() {
        return type;
    }

    public void addIngredient (String name ){

        if ( ! ingredientsList.contains(name) )
            ingredientsList.add(name) ;

    }

    public void addAllergen (Allergen a ){

        if ( ! allergenList.contains(a) )
            allergenList.add(a) ;

    }

    public void removeAllergen (Allergen a ){

        if ( allergenList.contains(a) )
            allergenList.remove(a) ;

    }

    public boolean containsAllergen(Allergen a){

         return allergenList.contains(a);

    }

    public String showDetails(){

        String tmp = name + "\n" ;

        for (String element : ingredientsList)
            tmp += element + " ;\n ";

        tmp += "\t" + price + " €" ;

        return tmp ;

    }

    public String toString() {

        return name + "\t" +  price + " €" ;

    }

    public String showAllergenes(){

        String tmp = name + "\n" ;

        for (Allergen element : allergenList)
            tmp += element + " ;\n";


        return tmp;
    }


}
