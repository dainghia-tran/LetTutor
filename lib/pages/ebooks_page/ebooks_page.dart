import 'package:flutter/material.dart';
import 'package:lettutor/pages/ebooks_page/widgets/ebook.dart';

class EBooksPage extends StatefulWidget {
  const EBooksPage({Key? key}) : super(key: key);

  @override
  _EBooksPageState createState() => _EBooksPageState();
}

class _EBooksPageState extends State<EBooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: const Text('E-Books', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Beginner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildEBookList('Beginner'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Intermediate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildEBookList('Intermediate'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Advanced', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildEBookList('Advanced'),
              ),
            ),
            const SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }

  _buildEBookList(String level){
    return List.generate(50, (index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: EBook(name: 'Book $index', description: 'Description $index', level: level),
    ));
  }
}
