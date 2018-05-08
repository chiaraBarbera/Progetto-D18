package tester;

import services.DbReader;
import services.Query;

public class TestDB {
    public static void main(String[] args) {
        DbReader dbr = new DbReader("esame","123456");

        boolean flags[] = {true,false,false};  //SIMULAZIONE FILTRI VEGAN,VEGETARIAN,CELIAC
        dbr.setQuery(Query.SELECT_ALL_DISHES);
        new Thread(dbr).start();
    }

}
