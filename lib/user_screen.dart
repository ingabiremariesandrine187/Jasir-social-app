import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'UserProfileScreen.dart';
import 'search_overlay.dart';
import 'create_post_page.dart'; // Make sure this is at the top
import 'play_screen.dart';



class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _isSearching = false;
TextEditingController _searchController = TextEditingController();
  bool _showBottomBar = true;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _showBottomBar = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showBottomBar = true;
        });
      }
    });

    String _getSlicedComment(String comment) {
      const int maxLength = 10; // Set a length limit
      if (comment.length <= maxLength) {
        return comment;
      } else {
        return comment.substring(0, maxLength) + '...';
      }
    }

    final List<Map<String, String>> postsData = [
      {
        'posterName': 'AsiimweApophia',
        'profileImage': 'assets/images/post.png',
        'postImage': 'assets/images/post.png',
        'likes': '744',
        'views': '22k',
        'hoursAgo': '2',
        'caption': 'Love is about what we share and experience.',
        'comment': 'Wow, what kind of love is this?',
        'commentCount': '160k',
      },
      {
        'posterName': 'Clemanceniyigena',
        'profileImage': 'assets/images/post.png',
        'postImage': 'assets/images/post2.jpg',
        'likes': '600',
        'views': '20k',
        'hoursAgo': '16',
        'caption': 'Clearing minds, catching vibes.',
        'comment': 'its amazing?',
        'commentCount': '1000k',
      },
      {
        'posterName': 'MarieSandrine',
        'profileImage': 'assets/images/post.png',
        'postImage': 'assets/images/post1.jpg',
        'likes': '504',
        'views': '200k',
        'hoursAgo': '20',
        'caption': 'Sometimes, all you need is a screen and a moment.',
        'comment': 'Wow, Interesting.',
        'commentCount': '160k',
      },
      {
        'posterName': 'MarieAlice',
        'profileImage': 'assets/images/post.png',
        'postImage': 'assets/images/post1.jpg',
        'likes': '504',
        'views': '200k',
        'hoursAgo': '20',
        'caption': 'Sometimes, all you need is a screen and a moment.',
        'comment': 'Wow, Interesting.',
        'commentCount': '160k',
      },
      {
        'posterName': 'Irenee',
        'profileImage': 'assets/images/post.png',
        'postImage': 'assets/images/post2.jpg',
        'likes': '504',
        'views': '200k',
        'hoursAgo': '20',
        'caption': 'Sometimes, all you need is a screen and a moment.',
        'comment': 'Wow, Interesting.',
        'commentCount': '160k',
      },
      {
        'posterName': 'UTUJELouange',
        'profileImage': 'assets/images/post1.jpg',
        'postImage': 'assets/images/post2.jpg',
        'likes': '504',
        'views': '200k',
        'hoursAgo': '20',
        'caption': 'Sometimes, all you need is a screen and a moment.',
        'comment': 'Wow, Interesting.',
        'commentCount': '160k',
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE4ECFF),
        body:
         LayoutBuilder(

          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    postsData.map((postData) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015, // Responsive margin
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            postData['profileImage']!),
                                        radius: screenWidth *
                                            0.04, // Responsive radius
                                      ),
                                      SizedBox(width: screenWidth * 0.025),
                                      Text(
                                        postData['posterName']!,
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.more_vert, color: Colors.black),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Image.asset(
                              postData['postImage']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: screenHeight * 0.25, // Responsive height
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.03),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Text(
                                                'Caption',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              content: Text(
                                                postData['caption']!,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Close',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        postData['caption']!,
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${postData['likes']} likes.',
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.035,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${postData['views']} views. ${postData['hoursAgo']} hours ago',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: screenWidth * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Container(
                                    padding: EdgeInsets.all(screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.05),
                                    ),
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'comments',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: screenWidth * 0.04,
                                                ),
                                              ),
                                              TextSpan(text: ' '),
                                              TextSpan(
                                                text:
                                                    '${postData['commentCount']}.',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: screenWidth * 0.04,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.03),
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/post.png'),
                                          radius: screenWidth *
                                              0.02, // Responsive radius
                                        ),
                                        SizedBox(width: screenWidth * 0.03),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Text(
                                                      'Full Comment',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    content: Text(
                                                      postData['comment']!,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('Close',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              _getSlicedComment(
                                                  postData['comment']!),
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.04,
                                                color: Colors.black,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0), // Left padding applied here
                              child: Row(
                                children: [
                                  // Like button with count
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFFF0F4FF), // Light background color from the image
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/africa.svg', // Your SVG file path
                                          color: Colors
                                              .grey, // Optional: Add color
                                          width:
                                              15, // Set width and height if needed
                                          height: 15,
                                        ), // Heart icon
                                        SizedBox(width: 8),
                                        Text('744K',
                                            style: TextStyle(
                                                color:
                                                    Colors.grey)), // Like count
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                  // Share button
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFFF0F4FF), // Light background color from the image
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/chatt.svg', // Your SVG file path
                                          color: Colors
                                              .grey, // Optional: Add color
                                          width:
                                              15, // Set width and height if needed
                                          height: 15,
                                        ), // Share icon
                                        SizedBox(width: 8),
                                        Text('Share',
                                            style: TextStyle(
                                                color: Colors
                                                    .grey)), // Share label
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                  // Save button
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFFF0F4FF), // Light background color from the image
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/save.svg', // Your SVG file path
                                          color: Colors
                                              .grey, // Optional: Add color
                                          width:
                                              15, // Set width and height if needed
                                          height: 15,
                                        ), // Save icon
                                        SizedBox(width: 8),
                                        Text('Save',
                                            style: TextStyle(
                                                color:
                                                    Colors.grey)), // Save label
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
       

        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _showBottomBar ? 60.0 : 0.0,
          margin: EdgeInsets.only(
              bottom: 20,
              left: 10,
              right: 10), // Bottom, left, and right margin
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF696A66), // Background color: #696A66
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0), // Fully rounded corners
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft:
                    Radius.circular(30.0), // Ensures full rounded corners
                bottomRight:
                    Radius.circular(30.0), // Ensures full rounded corners
              ),
              child: BottomAppBar(
                color: Colors
                    .transparent, // Keep it transparent to retain rounded edges
                shape: CircularNotchedRectangle(),
                notchMargin: 6.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home_outlined),
                      color: Colors.white,
                      onPressed: () {},
                    ),


                    
                   IconButton(
  icon: Icon(Icons.search),
  color: Colors.white,
  onPressed: () {
    setState(() {
      _isSearching = !_isSearching; // toggle the search overlay
    });
  },
),
                  IconButton(
  icon: Icon(Icons.add),
  color: Colors.white,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePostPage()),
    );
  },
),

                    IconButton(
  icon: Icon(Icons.play_arrow),
  color: Colors.white,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlayScreen()),
    );
  },
),
                    // Profile Avatar

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileScreen()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundImage: AssetImage('assets/images/pcc.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
//         Stack(
//   children: [
//     // Your other widgets go here (ListView, Column, etc)
//     // Example:
//     YourMainWidget(),

//     // This will show the search overlay at the top when icon is tapped
//     if (_isSearching)
//       SearchOverlay(
//         controller: _searchController,
//         onClear: () {
//           _searchController.clear();
//           setState(() {
//             _isSearching = false; // close the search bar
//           });
//         },
//       ),
//   ],
// ),
      ),
    );
  }
}
