<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<body>

<DIV id="dtab_1">
<div id="detailsformin" title="Information">


</div>

<div id="detailsformValin" title="Are you sure ?">


</div>


<div id="encountformDet" title="Information">


</div>
<div id="detailsformValinT" title="Are you sure ?">


</div>
<DIV id="incss">

    <a href="#" id="incomingformshow">Show Add Request </a>
    <a href="#" id="hideincomingform">Hide Add Request </a>

    <form id="incomingextrain" action="#">
        <hr color=#1aad9b width="100%">

        <fieldset>

            <legend>Extra information</legend>
            <br/>
            <label>Supplier</label>
            <select id="supplier" name="supplier" class="required">


            </select> <br/>
            <label>Quantity in</label>
            <input type="text" name="incomingnumber" id="incomingnumber" class="required"/> <br/> <br/>
            <label>Batch No</label>
            <input type="text" name="incomingbatch" id="incomingbatch" class="required"/> <br/> <br/>

            <label for="incomingexpire">Expire date</label>
            <input type="text" name="incomingexpire" id="incomingexpire" class="required"/> <br/> <br/>
            <label>Delivery No</label>
            <input type="text" name="delivery" id="delivery" class="required"/> <br/>


            </select>         <br/>
            <input type="hidden" name="incomingdrugg" id="incomingdrugg" class="required"/>
            <input type="hidden" name="incominguuidextra" id="incominguuidextra" class="required"/>
            <input class="submit" type="submit" value="Submit"/>
        </fieldset>
        <hr color=#1aad9b width="100%">

    </form>

    </form>
    <form id="s11">
        <fieldset>
            <table>
                <tr><td>S11 No. </td>
                    <td><input type="text" name="incomings11" id="incomings11" class="required"/> </td><td></td>
                    <td></td>
                    <td></td></tr>
                <tr><td><input type="hidden" name="dateCreated" id="dateCreated" class="required"/> </td></tr>
                <tr><td><label>Transactions Type</label> </td>
                    <td><select id="transactions" name="transactions" class="required"> </select> </td>
                    <td></td>
                    <td></td>
                    <td></td></tr>
                <tr><td><label>Requesting from</label> </td>
                    <td><select id="location" name="location" class="required"> </select> </td>
                    <td></td>
                    <td></td>
                    <td></td></tr></table>

            <label>Drug </label><label>Category</label> <label>Quantity</label><label class="hidable">Expiry date</label><label class="hidable">Batch NO</label><label class="hidable">Buying Price</label><label class="hidable">Selling Price</label><br />
            <table id="tableincoming">
                <tr><td><input type="text" name="incomingdrug" id="incomingdrug" class="required"/> </td>
                    <td><select id="incomingcategory" class="datavalues" name="incomingcategory" class="required"> </select></td>
                    <td><input type="text" class="datavalues" name="incomingquantityin" id="incomingquantityin" class="required"/> </td>
                    <td><input type="text"  name="date" id="date" class="hidable"/></td>
                    <td><input type="text" name="batchNo" id="batchNo" class="hidable"/> </td>
                    <td><input type="text" name="buyingPrice" id="buyingPrice" class="hidable"/> </td>
                    <td><input type="text" name="unitPrice" id="unitPrice" class="hidable"/> </td>
                </tr>
            </table>
            <input type="button"  value="Add Drug" onclick="addRow('tableincoming')"/>
            <input type="button"   value="Remove Drug" onclick="deleteRow('tableincoming')"/>
            <br/>
            <input class="submit" type="submit" value="Submit"/>
        </fieldset>

    </form>

    <form id="incoming">
        <fieldset>

            <label>S11 No.</label>
            <input type="text" name="incomings11" id="incomings111" class="required"/> <br/>

            <label>Transactions Type</label>
            <select id="transactions1" name="transactions" class="required"> </select> <br/>

            <label>Requesting from</label>
            <select id="location1" name="location" class="required">

            </select> <br/>
            <label>Drug </label>
            <input type="text" name="incomingdrug" id="incomingdrug" class="required"/> <br/>
            <label>category </label>
            <select id="incomingcategory1" class="datavalues" name="incomingcategory" class="required"> </select> <br/>
            <label>Quantity </label>
            <input type="text" name="incomingquantityin" id="incomingquantityin1" class="required"/> <br/>

            <input type="hidden" name="incomingedit" id="incomingedit" value="" class="required"/> <br/>
            <input type="hidden" name="incominguuid" id="incominguuid" value="" class="required"/> <br/>

            <input class="submit" type="submit" value="Submit"/>

            <br/>

            <br/>


        </fieldset>

    </form>

    <form id="incomingvoid" action="#">
        <hr color=#1aad9b width="100%">

        <fieldset>

            <legend> Void reason</legend>

            <label>Reason</label> <input type="text" name="incomingreason"
                                         id="incomingreason" class="required"/> <input type="hidden"
                                                                                       name="incominguuidvoid"
                                                                                       id="incominguuidvoid"/> <input
                class="submit"
                type="submit" value="Submit"/>
        </fieldset>
        <hr color=#1aad9b width="100%">

    </form>


    <div id='parent_div_1out'>


        <form id="filterincoming" action="#">
            <hr color=#1aad9b width="100%">

            <fieldset>

                <legend> Filter</legend>

                <label>Drug</label>
                <input type="text"
                       name="filterdrug" id="filterdrug"/>


            </fieldset>
            <hr color=#1aad9b width="100%">

        </form>
    </div>


</DIV>
<table cellpadding="0" cellspacing="0" border="0" class="display"
       id="tincoming">
    <thead>
    <tr>
        <th width="4%">Edit</th>
        <th>Actions</th>
        <th>UUID</th>
        <th>Drug</th>
        <th>Quantity</th>
        <th>From</th>
        <th>T-Type</th>

        <th>S11</th>
        <th>S11</th>
        <th>S11</th>
        <th>Details</th>
        <th>Details</th>
        <th>Details</th>
        <th>Details</th>


        <th>Details</th>

        <th>Approve</th>
        <th>Void</th>

        <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>

        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>


        <th></th>
        <th></th>
        <th></th>
        <th></th>


    </tr>
    </tbody>


</table>


</DIV>

</body>
</html>