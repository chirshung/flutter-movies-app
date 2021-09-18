import 'package:flutter/material.dart';
import 'package:flutter_movies_app/model/movie.dart';

class MovieListView extends StatelessWidget {
  //Define a list of movies that get data from 'movie.dart'
  final List<Movie> movieList = Movie.getMovies();

  //Main widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1.The App Bar
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movies'),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      //2.Background color
      backgroundColor: Colors.blueGrey.shade600,

      //3.Body: The movies listview
      //   Use ListView(itemBuilder: ...) => loads only visible items
      body: ListView.builder(
        //3.1.Identify the length of list to be displayed
        itemCount: movieList.length,

        //3.2.Display the movie list via 'itemBuilder'
        itemBuilder: (BuildContext context,int index){
          //context -> is current screen(tham chiếu đến màn hình hiện tại)
          //index   -> (là chỉ số của từng phần tử trong ListView)

          //call the ***** Option 1 for a basic CARD display in 'listView' *****
          // return basicMovieCard(movieList[index], context, index);

          //call the ***** Option 2 for a advance CARD display in 'InkWell' *****
          // return movieCard(movieList[index], context);

          //Use the Stack to position 'movieImage' Widget and 'movieCard' Widget
          return homeStack(movieList, context, index);
        },
      ),
    );
  }

  //***************** CARD Widget - Option 1 *****************
  //Define a basic CARD Widget using the 'ListView'
  Widget basicMovieCard(Movie movie, BuildContext context, int index){
    //return a CARD widget displaying the 'listView'
    return Card(
      //1. Decor Card
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(10),
      ),

      //2. Shadow of Card
      elevation: 5,

      //3.2.3. Color of Card
      color: (index - 1) % 2 == 0 ? Colors.grey.shade300 : Colors.grey.shade200,

      //3.2.4. Apply ListTile to Card
      child: ListTile(
        //3.2.4.1. 'leading': A widget to display before the title -> [Icon] or a [CircleAvatar] widget
        leading: CircleAvatar(
          child: Container(
            height: 200,
            width:  200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.images[0]),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.9),
            ),
            child: null,
          ),
          foregroundColor: Colors.deepOrange,
          backgroundColor: Colors.black12,
          maxRadius: 25,
        ),

        //3.2.4.2. 'trailing': A widget to display after the title.
        trailing: Text('...'),

        //3.2.4.3. 'title': The primary content of the list tile.
        title: Text(
          movie.title,
          style: TextStyle(
            color: Colors.black87,
            fontStyle: FontStyle.italic,
          ),
        ),

        //3.2.4.4. 'subtitle': Additional content displayed below the title.
        subtitle: Text('sub'),

        //3.2.4.5. Redirect to 'MovieListViewDetail' Route
        // onTap: () => debugPrint('Movie name: ${movies[index]}'),
        // onTap: () => debugPrint('Movie name: ${movies.elementAt(index)}'),
        onTap: () {
          Navigator.push(
              context,
              // Route<T>
              MaterialPageRoute(
                //Widget function
                  builder: (context){
                    //return a custom widget
                    return MovieListViewDetail(
                      movieName: movie.title,
                      movie: movie,
                    );
                  }));

          // Navigator.of(context).push(
          //     // Route<T>
          //     MaterialPageRoute(
          //       //Widget function
          //       builder: (context){
          //         //return a custom widget
          //         return MovieListViewDetail();
          //     })
          // );
        },
      ),
    );
  }

  //***************** CARD Widget - Option 2 *****************
  //Define a advanced CARD Widget without the 'listView'.
  // Use the 'InkWell' to wrap the CARD and show them in list without 'listView'.
  Widget movieCard(Movie movie, BuildContext context){
    //return a 'InkWell' widget wrapped the CARD
    return InkWell(
      //A.Use 'Container' to design the CARD InkWell accordingly
      child: Container(
        margin: EdgeInsets.only(left: 54),
        //1.Use 'MediaQuery' to determine the width applying on every devices.
        width: MediaQuery.of(context).size.width,
        height: 120.0,

        //2.Declare CARD and draw the it
        child: Card(
          //2.1.CARD color
          color: Colors.black45,

          //2.2.Draw a column with 1 row to add the information of CART to
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 55.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                //Use 'MainAxisAlignment.spaceAround' to set space around the Column Widget
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //2.2.1. The first row to display 'Title' and 'Rating'
                  Row(
                    //Use 'MainAxisAlignment.spaceBetween' to set space between the children: <Widget>
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Movie Title
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Movie Rating
                      Text(
                        'Rating: ${movie.imdbRating}/10',
                        style: mainTextStyle(),
                      ),
                    ],
                  ),
                  //2.2.2. The second row to display other information
                  Row(
                    //Use 'MainAxisAlignment.spaceBetween' to set space around the children: <Widget>
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //Release
                        Flexible(
                            child: Text(
                              'Release: ${movie.released}',
                              style: mainTextStyle(),
                            )
                        ),
                        //Runtime
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('${movie.runtime}',style: mainTextStyle(),),
                        ),
                        //Rated
                        Text('${movie.rated}',style: mainTextStyle(),),

                      ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      //B.call the action of InkWell => Redirect to 'MovieListViewDetail' Route
      onTap: (){
        Navigator.push(
            context,
            // Route<T>
            MaterialPageRoute(
              //Widget function
                builder: (context){
                  //return a custom widget
                  return MovieListViewDetail(
                    movieName: movie.title,
                    movie: movie,
                  );
                }));
      },
    );
  }

  //define a 'TextStyle'
  TextStyle mainTextStyle(){
    return TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
  }

  //***************** Image Widget *****************
  Widget movieImage(String imageUrl){
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTA0NjY0NzE4OTReQTJeQWpwZ15BbWU3MDczODg2Nzc@._V1_SX1777_CR0,0,1777,999_AL_.jpg' ),
          fit: BoxFit.cover,
        ),

      ),
    );
  }

  //***************** Home Stack Widget *****************
  //Use 'Stack' widget:
  // A widget that positions its children relative to the edges of its box.
  // This class is useful if you want to overlap several children in a simple
  // way, for example having some text and an image, overlaid with a gradient and
  // a button attached to the bottom.
  Widget homeStack(List<Movie> movieList, BuildContext context, int index){
    return Stack(
      children: <Widget>[
        //first child is at the bottom
        Positioned(
          child: movieCard(movieList[index], context)),
        //second child is in font
        Positioned(
          top: 10.0,
          child: movieImage(movieList[index].images[0])
        ),
      ],
    );
  }
}



//Define the 'MovieListViewDetail' route (screen / page)
class MovieListViewDetail extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetail({Key key, this.movieName, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1.The App Bar
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie'),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      //2.Background color
      backgroundColor: Colors.white ,

      //3.Body: the 'Back' button
      body: Center(
        child: RaisedButton(
          child: Text('Go Back. ${this.movie.director}'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
