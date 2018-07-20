<%@ page import="menu.DishType" %>
<%@ page import="menu.MenuElement" %>
<%@ page import="restaurant.Catalogue" %>
<%@ page import="restaurant.Restaurant" %>
<%@ page import="menu.Allergen" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="restaurant.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="../stylesheets/SelectionTemplateStyle.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" crossorigin="anonymous"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" crossorigin="anonymous"
            integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
    <%  Catalogue catalogue = Restaurant.getRestaurantInstance().getDishesCatalogue();
        Reservation reservation = (Reservation) request.getSession().getAttribute("reservation");

        String filters[] = request.getParameterValues("filter");
        boolean veg = false, vgt = false, cel = false;
        if (filters != null) {
            for (String f : filters) {
                if (f.equalsIgnoreCase("veg"))
                    veg = true;
                else if (f.equalsIgnoreCase("vgt"))
                    vgt = true;
                else if (f.equalsIgnoreCase("cel"))
                    cel = true;
            }
        }

        String allergens = "";
        String selectedAllergens[] = request.getParameterValues("allergen");
        if (selectedAllergens != null)
            allergens = String.join("", selectedAllergens);

        ArrayList<MenuElement> filteredList = catalogue.getFilteredList(veg, vgt, cel, allergens);
    %>

    $(document).ready(function(){
        $("input[name='selected-id']").on("change", function() {
            var selectedList = [];
            var pricesList = [];
            $('input[name=\'selected-id\']:checked').each(function() {
                var label = $(this).siblings('label');
                selectedList.push(label.text());
                pricesList.push(label.attr('data-price'));
            });

            var content = '';
            for(var i = 0; i < selectedList.length; i++)
                content += '<tr><th>' + selectedList[i] + '</th><td>' + pricesList[i] + '0 &euro;</td></tr>';
            $('#checkout').html(content);
        });

        $('.dropdown-menu').on('click', function(e) {
            e.stopPropagation();
        });
    });
    </script>

</head>
<body background="../img/background.jpg">

<jsp:include page="navbar.jsp"/>



<br/>
<div class="container">
    <form action="/selection" method="post" class="jumbotron" style="background: #ffffff">
        <h2>Filters</h2>
        <div class="custom-control custom-checkbox custom-control-inline">
            <input type="checkbox" id="vegetarian" name="filter" class="custom-control-input" value="vgt" <% if (vgt) out.print("checked"); %>>
            <label class="custom-control-label" for="vegetarian">Vegetarian</label>
        </div>
        <div class="custom-control custom-checkbox custom-control-inline">
            <input type="checkbox" id="vegan" name="filter" class="custom-control-input" value="veg" <% if (veg) out.print("checked"); %>>
            <label class="custom-control-label" for="vegan">Vegan</label>
        </div>
        <div class="custom-control custom-checkbox custom-control-inline">
            <input type="checkbox" id="celiac" name="filter" class="custom-control-input" value="cel" <% if (cel) out.print("checked"); %>>
            <label class="custom-control-label" for="celiac">Celiac</label>
        </div>

        <div class="dropdown" style="display: inline">
            <button class="btn btn-primary btn-styled dropdown-toggle" type="button" id="dropbtn" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false" style="margin-left: 15%;">Allergens to avoid</button>

            <div class="dropdown-menu" aria-labelledby="dropbtn">
                <%for (Allergen elem : catalogue.getAllergens()) {%>
                    <div class="custom-control custom-checkbox" style="margin-left: 0.9em; margin-right: 0.9em">
                        <input type="checkbox" id="<%=elem.getAllergenCode()%>" name="allergen" class="custom-control-input"
                               value="<%=elem.getAllergenCode()%>" <% if (allergens.contains(elem.getAllergenCode())) out.print("checked"); %>>
                        <label class="custom-control-label" for="<%=elem.getAllergenCode()%>"><%=elem.toString()%></label>
                    </div>
                <%}%>
            </div>
        </div>

        <input type="submit" style="float: right;" class="btn btn-primary btn-styled" value="Apply">
    </form>
</div>

<div class="jumbotron" style="margin-left: 5%; margin-right: 5%; background: #ffffffc0">
    <div class="row" style="margin-left: 1%; margin-right: 1%">
        <div class="col-sm-2">
            <div class="list-group" id="list-tab" role="tablist">
                <a class="list-group-item list-group-item-action active" id="starters-tab" data-toggle="list"
                   href="#starters" role="tab" aria-controls="starters"><b>Starters</b></a>
                <a class="list-group-item list-group-item-action" id="first-tab" data-toggle="list"
                   href="#first-courses" role="tab" aria-controls="first"><b>First courses</b></a>
                <a class="list-group-item list-group-item-action" id="main-tab" data-toggle="list"
                   href="#main-courses" role="tab" aria-controls="main"><b>Main courses</b></a>
                <a class="list-group-item list-group-item-action" id="desserts-tab" data-toggle="list"
                   href="#desserts" role="tab" aria-controls="desserts"><b>Desserts</b></a>
                <a class="list-group-item list-group-item-action" id="drinks-tab" data-toggle="list"
                   href="#drinks" role="tab" aria-controls="drinks"><b>Drinks</b></a>
            </div>
        </div>
        <form class="col-sm-7" action="/status" method="post" id="selected-dishes">
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="starters" role="tabpanel" aria-labelledby="starters-tab">
                    <div class="card">
                        <div class="card-body">

                        <%  for (MenuElement item : filteredList) {
                                    if (item.getType().equals(DishType.STARTER)) {  %>
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="<%=item.getElementCode()%>" name="selected-id" value="<%=item.getElementCode()%>">
                                        <label class="custom-control-label" for="<%=item.getElementCode()%>" data-price="<%=item.getPrice()%>"> <%=item.getName()%> </label>
                                     </div>
                                <%  }
                                }   %>
                        </div>
                    </div>
				</div>

                <div class="tab-pane fade" id="first-courses" role="tabpanel" aria-labelledby="first-tab">
                    <div class="card">
                        <div class="card-body">

                            <%  for (MenuElement item : filteredList) {
                                    if (item.getType().equals(DishType.FIRST_COURSE)) {  %>
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="<%=item.getElementCode()%>" name="selected-id" value="<%=item.getElementCode()%>">
                                <label class="custom-control-label" for="<%=item.getElementCode()%>" data-price="<%=item.getPrice()%>"> <%=item.getName()%> </label>
                            </div>
                            <%  }
                            }   %>

                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="main-courses" role="tabpanel" aria-labelledby="main-tab">
                    <div class="card">
                        <div class="card-body">

                            <%  for (MenuElement item : filteredList) {
                                if (item.getType().equals(DishType.MAIN_COURSE)) {  %>
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="<%=item.getElementCode()%>" name="selected-id" value="<%=item.getElementCode()%>">
                                <label class="custom-control-label" for="<%=item.getElementCode()%>" data-price="<%=item.getPrice()%>"> <%=item.getName()%> </label>
                            </div>
                            <%  }
                            }   %>

                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="desserts" role="tabpanel" aria-labelledby="desserts-tab">
                    <div class="card">
                        <div class="card-body">

                            <%  for (MenuElement item : filteredList) {
                                if (item.getType().equals(DishType.DESSERT)) {  %>
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="<%=item.getElementCode()%>" name="selected-id" value="<%=item.getElementCode()%>">
                                <label class="custom-control-label" for="<%=item.getElementCode()%>" data-price="<%=item.getPrice()%>"> <%=item.getName()%> </label>
                            </div>
                            <%  }
                            }   %>

                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="drinks" role="tabpanel" aria-labelledby="drinks-tab">
                    <div class="card">
                        <div class="card-body">

                            <%  for (MenuElement item : filteredList) {
                                if (item.getType().equals(DishType.DRINK)) {  %>
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="<%=item.getElementCode()%>" name="selected-id" value="<%=item.getElementCode()%>">
                                <label class="custom-control-label" for="<%=item.getElementCode()%>" data-price="<%=item.getPrice()%>"> <%=item.getName()%> </label>
                            </div>
                            <%  }
                            }   %>

                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="col-sm-3">
            <div class="card">
                <div class="card-header bg-dark text-white"><b>Menu checkout</b></div>
                <div class="card-body">
                    <table class="table table-sm">
                        <thead>
                        <tr>
                            <th><span style="color: dodgerblue">Dish</span></th>
                            <th><span style="color: dodgerblue">Price</span></th>
                        </tr>
                        </thead>
                        <tbody id="checkout">
                        </tbody>
                    </table>
                </div>
            </div>

            <br/>
            <div class="form-group row">
                <label for="menuName" class="col-sm-4 col-form-label">Menu name</label>
                <input type="text" class="form-control col-sm-7" id="menuName" name="menuName" form="selected-dishes" placeholder="(Optional)">
            </div>
            <div class="form-group row" style="margin-top: -3%">
                <label for="people" class="col-sm-4 col-form-label">People n.</label>
                <input type="number" class="form-control col-sm-4" id="people" name="people" form="selected-dishes" required min="1" max="<%=reservation.getnGuests()%>">
            </div>

            <input type="hidden" name="backToStatus" form="selected-dishes" value="new-menu">
            <input type="submit" class="btn btn-success" value="Submit" form="selected-dishes" style="float: right">
            <form action="/status" method="post">
                <input type="hidden" name="backToStatus" value="back">
                <input type="submit" class="btn btn-dark" value="&laquo;Back" style="float: right; margin-right: 2%; background-color: #e34d4d; border-color: #e34d4d">
            </form>
        </div>
    </div>
</div>

</body>
</html>
