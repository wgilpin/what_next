const dynamic tmdbMockGenreList = {
  "genres": [
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 16, "name": "Animation"},
    {"id": 35, "name": "Comedy"},
    {"id": 80, "name": "Crime"},
    {"id": 99, "name": "Documentary"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"},
    {"id": 14, "name": "Fantasy"},
    {"id": 36, "name": "History"},
    {"id": 27, "name": "Horror"},
    {"id": 10402, "name": "Music"},
    {"id": 9648, "name": "Mystery"},
    {"id": 10749, "name": "Romance"},
    {"id": 878, "name": "Science Fiction"},
    {"id": 10770, "name": "TV Movie"},
    {"id": 53, "name": "Thriller"},
    {"id": 10752, "name": "War"},
    {"id": 37, "name": "Western"}
  ]
};

const dynamic tmdbMockSearchResultsTV = {
  "page": 1,
  "results": [
    {
      "backdrop_path": "/1rO4xoCo4Z5WubK0OwdVll3DPYo.jpg",
      "first_air_date": "2022-09-01",
      "genre_ids": [10765, 10759, 18],
      "id": 84773,
      "name": "The Lord of the Rings: The Rings of Power",
      "origin_country": ["US"],
      "original_language": "en",
      "original_name": "The Lord of the Rings: The Rings of Power",
      "overview":
          "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
      "popularity": 724.059,
      "poster_path": "/mYLOqiStMxDK3fYZFirgrMt8z5d.jpg",
      "vote_average": 7.6,
      "vote_count": 1560
    },
    {
      "backdrop_path": "/dVJT32Wou3Cx1XfhijaAloJa2UR.jpg",
      "first_air_date": "1991-04-13",
      "genre_ids": [10762, 10765],
      "id": 123034,
      "name": "The Keepers",
      "origin_country": ["SU"],
      "original_language": "ru",
      "original_name": "Хранители",
      "overview":
          "Soviet live-action film adaptation of J. R. R. Tolkien’s The Fellowship of the Ring, aired once in 1991 by Leningrad Television and then thought lost. It was rediscovered in 2021. It includes scenes of Tom Bombadil and the Barrow-wight omitted from Peter Jackson’s Lord of the Rings film trilogy.",
      "popularity": 2.218,
      "poster_path": "/jOTLe14XueFZpy6vKVO28cmtcJB.jpg",
      "vote_average": 9,
      "vote_count": 2
    }
  ],
  "total_pages": 1,
  "total_results": 2
};

const dynamic tmdbMockSearchResultsMovie = {
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/kWYfW2Re0rUDE6IHhy4CRuKWeFr.jpg",
      "genre_ids": [12, 14, 28],
      "id": 121,
      "original_language": "en",
      "original_title": "The Lord of the Rings: The Two Towers",
      "overview":
          "Frodo and Sam are trekking to Mordor to destroy the One Ring of Power while Gimli, Legolas and Aragorn search for the orc-captured Merry and Pippin. All along, nefarious wizard Saruman awaits the Fellowship members at the Orthanc Tower in Isengard.",
      "popularity": 84.348,
      "poster_path": "/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg",
      "release_date": "2002-12-18",
      "title": "The Lord of the Rings: The Two Towers",
      "video": false,
      "vote_average": 8.4,
      "vote_count": 18969
    },
    {
      "adult": false,
      "backdrop_path": "/gU84vBGG2x8K3x1zrz4SggiN5hr.jpg",
      "genre_ids": [12, 14, 28],
      "id": 120,
      "original_language": "en",
      "original_title": "The Lord of the Rings: The Fellowship of the Ring",
      "overview":
          "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.",
      "popularity": 101.823,
      "poster_path": "/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg",
      "release_date": "2001-12-18",
      "title": "The Lord of the Rings: The Fellowship of the Ring",
      "video": false,
      "vote_average": 8.4,
      "vote_count": 21837
    },
    {
      "adult": false,
      "backdrop_path": "/lXhgCODAbBXL5buk9yEmTpOoOgR.jpg",
      "genre_ids": [12, 14, 28],
      "id": 122,
      "original_language": "en",
      "original_title": "The Lord of the Rings: The Return of the King",
      "overview":
          "Aragorn is revealed as the heir to the ancient kings as he, Gandalf and the other members of the broken fellowship struggle to save Gondor from Sauron's forces. Meanwhile, Frodo and Sam take the ring closer to the heart of Mordor, the dark lord's realm.",
      "popularity": 87.284,
      "poster_path": "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg",
      "release_date": "2003-12-01",
      "title": "The Lord of the Rings: The Return of the King",
      "video": false,
      "vote_average": 8.5,
      "vote_count": 20589
    },
    {
      "adult": false,
      "backdrop_path": "/x9McE1WFKnAHludiY7xfd7modDC.jpg",
      "genre_ids": [12, 16, 14],
      "id": 123,
      "original_language": "en",
      "original_title": "The Lord of the Rings",
      "overview":
          "The Fellowship of the Ring embark on a journey to destroy the One Ring and end Sauron's reign over Middle-earth.",
      "popularity": 29.31,
      "poster_path": "/liW0mjvTyLs7UCumaHhx3PpU4VT.jpg",
      "release_date": "1978-11-15",
      "title": "The Lord of the Rings",
      "video": false,
      "vote_average": 6.6,
      "vote_count": 686
    },
    {
      "adult": false,
      "backdrop_path": "/1mtjTIcwlo6YmGrJEr7fnGeITx3.jpg",
      "genre_ids": [14, 12, 18],
      "id": 1016184,
      "original_language": "en",
      "original_title":
          "The Lord of the Rings: The Rings of Power Global Fan Screening",
      "overview":
          "An edited version of the first two episodes of The Lord of the Rings: The Rings of Power, shown exclusively to fans in cinemas around the world in August 2022. In a time of relative peace, an ensemble cast of characters confronts the re-emergence of evil to Middle-earth.",
      "popularity": 9.618,
      "poster_path": "/toEUQXyDut4QecjC3RAdBoDVlUe.jpg",
      "release_date": "2022-08-31",
      "title": "The Lord of the Rings: The Rings of Power Global Fan Screening",
      "video": true,
      "vote_average": 7.2,
      "vote_count": 16
    },
    {
      "adult": false,
      "backdrop_path": "/gVDRFOeIsbxt6Axuoc1EHSMJTIe.jpg",
      "genre_ids": [16, 14, 28],
      "id": 839033,
      "original_language": "en",
      "original_title": "The Lord of the Rings: The War of the Rohirrim",
      "overview":
          "Focused on the mighty King of Rohan, Helm Hammerhand, and a legendary battle which helped shaped Middle Earth leading into the events of The Lord of The Rings.",
      "popularity": 3.945,
      "poster_path": "/lq7wL3Vcg4c6KkYzoPdOC46s4lT.jpg",
      "release_date": "2024-04-10",
      "title": "The Lord of the Rings: The War of the Rohirrim",
      "video": false,
      "vote_average": 0,
      "vote_count": 0
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [99, 10770],
      "id": 453779,
      "original_language": "en",
      "original_title":
          "A Passage to Middle-earth: Making of 'Lord of the Rings'",
      "overview": "",
      "popularity": 1.945,
      "poster_path": "/sDsmtdmsS1KqJTKwKb1hJ9VFL6w.jpg",
      "release_date": "2001-12-09",
      "title": "A Passage to Middle-earth: Making of 'Lord of the Rings'",
      "video": false,
      "vote_average": 6.4,
      "vote_count": 5
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [],
      "id": 945739,
      "original_language": "en",
      "original_title": "Darla's Book Club: Discussing the Lord of the Rings",
      "overview": "",
      "popularity": 0.671,
      "poster_path": "/cBdXohO3uOFnhI0NGs6TOpqabBt.jpg",
      "release_date": "2021-11-26",
      "title": "Darla's Book Club: Discussing the Lord of the Rings",
      "video": false,
      "vote_average": 10,
      "vote_count": 1
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [10402],
      "id": 155586,
      "original_language": "en",
      "original_title": "Creating the Lord of the Rings Symphony",
      "overview":
          "Creating The Lord of the Rings Symphony includes excerpts of live concert footage from The Lord of the Rings Symphony: Six Movements for Orchestra, Chorus and Soloists, documentary commentary by Howard Shore, and the illustrations of Alan Lee and John Howe.",
      "popularity": 0.6,
      "poster_path": "/bOb6CMJLnDzTwZHsoPQ0nkSnpnx.jpg",
      "release_date": "2004-12-14",
      "title": "Creating the Lord of the Rings Symphony",
      "video": false,
      "vote_average": 5.9,
      "vote_count": 4
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [99],
      "id": 296260,
      "original_language": "en",
      "original_title":
          "Master of the Rings: The Unauthorized Story Behind J.R.R. Tolkien's 'Lord of the Rings'",
      "overview":
          "This documentary examines the social and cultural underpinnings of the trilogy of The Lord of the Rings by J.R.R. Tolkien, in an attempt to understand the work's phenomenal success and influence. The program looks for answers in the author's sources of inspiration, from the folk legends of Norway to the field of linguistics of which Tolkien was a lifelong student. It finds that the deep chord the story strikes owes its resonance to the author's use of archetypal imagery and language. Many examples of these recurrent themes and images are given, with readings from the work and other literature. Interviews with the book's illustrators, the brothers Hildebrandt, speak to the power of the imagery in the classic story. Scholars, Tolkien's children, and the author himself provide insight into the mythic themes and the spell they have cast over the vast readership of The Lord of the Rings.",
      "popularity": 1.072,
      "poster_path": "/7fzIaIcpj4f0O3IHE65qGqlNcuL.jpg",
      "release_date": "2001-12-04",
      "title":
          "Master of the Rings: The Unauthorized Story Behind J.R.R. Tolkien's 'Lord of the Rings'",
      "video": false,
      "vote_average": 8,
      "vote_count": 1
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [99],
      "id": 1035526,
      "original_language": "en",
      "original_title":
          "Forging Through the Darkness: The Ralph Bakshi Vision for 'The Lord of the Rings'",
      "overview":
          "A deep look at how Ralph Bakshi made his version of Lord of the Rings (1978). With Ralph Bakshi, Victoria Bakshi-Yudis, Chris Conkling, Timothy Galfas, Scott Kleinman, & Tom Tataranowicz.",
      "popularity": 0.6,
      "poster_path": null,
      "release_date": "2010-04-10",
      "title":
          "Forging Through the Darkness: The Ralph Bakshi Vision for 'The Lord of the Rings'",
      "video": false,
      "vote_average": 0,
      "vote_count": 0
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [],
      "id": 651342,
      "original_language": "en",
      "original_title":
          "J.R.R. Tolkien and the Birth Of \"The Lord of the Rings\" And \"The Hobbit\"",
      "overview":
          "In a house in Oxford lived a remarkable man called J.R.R. Tolkien who told stories that thrilled the world. To this very day readers and film audiences are enjoying his magnificent epics “THE LORD OF THE RINGS” and “The Hobbit” – adapted to the big screen by producer, Peter Jackson. Although everybody has heard of Tolkien’s writing, very few people could tell you much about the man responsible for creating the best loved magical creatures that have become household names. This program will give you a real insight into the man behind the legends of “THE LORD OF THE RINGS,” and the people and places that shaped his unique literary genius. From the rolling English countryside to the sooty streets of Industrial Birmingham, the dreaming spires of Oxford to the World War I trenches of the blood soaked Somme; this is the story of the quintessential English College Professor who made epic mythology and legend accessible to one and all.",
      "popularity": 0.6,
      "poster_path": "/jp0NQtIQTwen5vHBNcCK2iLKoY7.jpg",
      "release_date": "2004-12-31",
      "title":
          "J.R.R. Tolkien and the Birth Of \"The Lord of the Rings\" And \"The Hobbit\"",
      "video": false,
      "vote_average": 2,
      "vote_count": 1
    },
    {
      "adult": false,
      "backdrop_path": "/qNVf39jp9fZSLd1bWMYjOrrEkI2.jpg",
      "genre_ids": [10751, 14, 16, 12, 10770],
      "id": 1362,
      "original_language": "en",
      "original_title": "The Hobbit",
      "overview":
          "Bilbo Baggins the Hobbit was just minding his own business, when his occasional visitor Gandalf the Wizard drops in one night. One by one, a whole group of dwarves drop in, and before he knows it, Bilbo has joined their quest to reclaim their kingdom, taken from them by the evil dragon Smaug. The only problem is that Gandalf has told the dwarves that Bilbo is an expert burglar, but he isn't...",
      "popularity": 17.05,
      "poster_path": "/2ohvyMPhvjftLrM6S6Ljr6QrL0u.jpg",
      "release_date": "1977-11-27",
      "title": "The Hobbit",
      "video": false,
      "vote_average": 6.3,
      "vote_count": 219
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [99, 10770],
      "id": 573089,
      "original_language": "en",
      "original_title": "The Quest Fulfilled: A Director's Vision",
      "overview": "",
      "popularity": 1.9,
      "poster_path": "/mGtbuCLQZ3xI02juytVRXHOQJoD.jpg",
      "release_date": "2003-12-26",
      "title": "The Quest Fulfilled: A Director's Vision",
      "video": false,
      "vote_average": 5.4,
      "vote_count": 4
    },
    {
      "adult": false,
      "backdrop_path": "/fBzwSM5zl4xp9L3rFu1PihmY0vh.jpg",
      "genre_ids": [16, 14, 12],
      "id": 1361,
      "original_language": "en",
      "original_title": "The Return of the King",
      "overview":
          "Two Hobbits struggle to destroy the Ring in Mount Doom while their friends desperately fight evil Lord Sauron's forces in a final battle.",
      "popularity": 11.877,
      "poster_path": "/4Jt6i7iWSs5I81RPB17Ks5K0N49.jpg",
      "release_date": "1980-05-11",
      "title": "The Return of the King",
      "video": false,
      "vote_average": 6.5,
      "vote_count": 153
    },
    {
      "adult": false,
      "backdrop_path": "/12rwHElCwSXRpLBtDS2Ef5zpol8.jpg",
      "genre_ids": [99],
      "id": 622231,
      "original_language": "en",
      "original_title": "The Making of The Fellowship of the Ring",
      "overview":
          "A behind the scenes documentary from the making of the \"Fellowship of the Ring\"",
      "popularity": 1.271,
      "poster_path": "/8MMx4xLKbiaexJ5anH66s7jVCD7.jpg",
      "release_date": "2006-08-29",
      "title": "The Making of The Fellowship of the Ring",
      "video": false,
      "vote_average": 9.3,
      "vote_count": 3
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [99],
      "id": 622236,
      "original_language": "en",
      "original_title": "The Making of The Two Towers",
      "overview":
          "A behind the scenes documentary from the making of the \"Two Towers\"",
      "popularity": 0.694,
      "poster_path": "/zrcL156wXTcfS3wzziCmr8uessx.jpg",
      "release_date": "2006-08-29",
      "title": "The Making of The Two Towers",
      "video": false,
      "vote_average": 9.3,
      "vote_count": 3
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [99],
      "id": 517834,
      "original_language": "en",
      "original_title": "The Making of The Return of the King",
      "overview":
          "Created by filmmaker Costa Botes (personally selected by Peter Jackson), this documentary uses raw footage to reveal the inside story on how the greatest adventure film franchise was born. Included as a bonus feature with \"The Lord of the Rings: The Return of the King - Limited Edition\".",
      "popularity": 0.761,
      "poster_path": "/QO5OYEHAcB3DUZju3j9mFm1BfF.jpg",
      "release_date": "2006-08-29",
      "title": "The Making of The Return of the King",
      "video": false,
      "vote_average": 8,
      "vote_count": 4
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [99],
      "id": 192349,
      "original_language": "en",
      "original_title": "Beyond the Movie: The Fellowship of the Ring",
      "overview":
          "A documentary about the influences on Tolkien, covering in brief his childhood and how he detested the onslaught of industry through the idyllic countryside, moving on to describe his fighting experience from WWI, and closing with a look at the Finnish inspiration for the scholar's self-invented languages of Elfish. In between are interviews with the cast of the films and some clips, by far the most from \"The Fellowship of the Ring\", but a few glimpses of Rohan riders (from \"The Two Towers\") are provided. Also, there are interviews with a range of the filmmakers.",
      "popularity": 2.526,
      "poster_path": "/knCJvfbr4LWNZBkTDlwRdM28PuR.jpg",
      "release_date": "2001-12-23",
      "title": "Beyond the Movie: The Fellowship of the Ring",
      "video": false,
      "vote_average": 5.7,
      "vote_count": 12
    },
    {
      "adult": false,
      "backdrop_path": "/6So1F3UlHkvXwziKabnTLyeUrnA.jpg",
      "genre_ids": [99],
      "id": 218166,
      "original_language": "en",
      "original_title": "Beyond the Movie: The Return of the King",
      "overview":
          "Documentary exploring the parallels between The Return of the King and real events and people in history.",
      "popularity": 0.6,
      "poster_path": "/mVIJapNx0MehdVWgIRlaY0in0XY.jpg",
      "release_date": "2003-12-21",
      "title": "Beyond the Movie: The Return of the King",
      "video": false,
      "vote_average": 7.7,
      "vote_count": 3
    }
  ],
  "total_pages": 1,
  "total_results": 20
};
