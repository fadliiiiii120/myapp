import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/USER/all%20page/cartmodel.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Keranjang',
            style:
                TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          leadingWidth: 70,
          centerTitle: true,
          backgroundColor: Colors.transparent),
      backgroundColor: Color.fromARGB(206, 197, 197, 197),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Image.asset(item.image, width: 50, height: 50),
                      title: Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text untuk item price
                          Text(
                            'Rp ${(item.price * item.quantity)}',
                            style: TextStyle(fontSize: 16),
                          ),
                          // Row untuk qty dan tombol - +
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => cart.decreaseQuantity(item),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => cart.increaseQuantity(item),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

//box total dan checkout
          SizedBox(
            height: 130, // Total height for both Text and ElevatedButton
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: 50, // tinggi box Text
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total : Rp.${(cart.total)}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 10), // Space antara Text and Button
                  Container(
                    height: 40, // tinggi ElevatedButton
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(243, 162, 11, 1),
                      ),
                      onPressed: () {
                        //link checkout
                      },
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
