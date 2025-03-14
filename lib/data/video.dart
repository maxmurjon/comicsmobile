// dummy_data.dart (Comics Kurslari)
import 'models/cource.dart';

List<VideoCourse> getVideoCourses() {
  return [
    VideoCourse(

      name: "Komiks San'ati Ustasi: Noldan Ranggacha",
      description: "O'zingizning komiks san'atingizni yaratishni o'rganing, asosiy eskizlardan to to'liq ranglangan asarlargacha.",
      price: 149.99,
      imageUrls: [
        'https://cdn.domestika.org/c_fill,f_auto,pg_1,w_1000,dpr_1,ar_16:9/v1657724268/course-covers/000/003/282/3282-original.jpg?1657724268',
        'https://example.com/comics2.jpg',
        'https://example.com/comics3.jpg',
      ],
      modules: [
        VideoModule(
          title: "Komiks San'atiga Kirish",
          videoUrl: "https://www.example.com/video_comics_intro.mp4",
          videos: [
            Video(videoTitle: "Komiks San'ati Nima?", videoUrl: "https://www.example.com/video_comics_intro1.mp4"),
            Video(videoTitle: "Komiks uchun Materiallar va Asboblar", videoUrl: "https://www.example.com/video_comics_intro2.mp4"),
            Video(videoTitle: "Komiks Layoutlarini Tushunish", videoUrl: "https://www.example.com/video_comics_intro3.mp4"),
            Video(videoTitle: "Asosiy Chizish Texnikalari", videoUrl: "https://www.example.com/video_comics_intro4.mp4"),
            Video(videoTitle: "Birinci Komiks Sahifangizni Yaratish", videoUrl: "https://www.example.com/video_comics_intro5.mp4"),
          ],
        ),
        VideoModule(
          title: "Personajni Dizayn Qilish va Rivojlantirish",
          videoUrl: "https://www.example.com/video_comics_characters.mp4",
          videos: [
            Video(videoTitle: "Komiks Personajlarini Yaratish", videoUrl: "https://www.example.com/video_comics_characters1.mp4"),
            Video(videoTitle: "Yuz ifodalari va Tanasi Tilini Chizish", videoUrl: "https://www.example.com/video_comics_characters2.mp4"),
            Video(videoTitle: "Komiksda Rang Teoriyasi", videoUrl: "https://www.example.com/video_comics_characters3.mp4"),
          ],
        ),
        VideoModule(
          title: "Komiksda Hikoya Qilish",
          videoUrl: "https://www.example.com/video_comics_storytelling.mp4",
          videos: [
            Video(videoTitle: "Komiks Ssenariysini Yozish", videoUrl: "https://www.example.com/video_comics_story1.mp4"),
            Video(videoTitle: "Panel Layouti va Tizimi", videoUrl: "https://www.example.com/video_comics_story2.mp4"),
            Video(videoTitle: "Drama va Emotsiyani Qo'shish", videoUrl: "https://www.example.com/video_comics_story3.mp4"),
          ],
        ),
        VideoModule(
          title: "Komiksni Ranglash Texnikalari",
          videoUrl: "https://www.example.com/video_comics_coloring.mp4",
          videos: [
            Video(videoTitle: "Komiksni Ranglashga Kirish", videoUrl: "https://www.example.com/video_comics_coloring1.mp4"),
            Video(videoTitle: "Raqamli va An'anaviy Ranglash", videoUrl: "https://www.example.com/video_comics_coloring2.mp4"),
            Video(videoTitle: "So'laklar va Yoritish", videoUrl: "https://www.example.com/video_comics_coloring3.mp4"),
          ],
        ),
      ],
    ),
    VideoCourse(
      name: "Procreate Bilan Raqamli Komiks Yaratish",
      description: "Procreate dasturini ishlatib, o'zining professional darajadagi komikslarini yaratishni o'rganing.",
      price: 119.99,
      imageUrls: [
        'https://cdn.domestika.org/c_fill,f_auto,pg_1,w_1000,dpr_1,ar_16:9/v1609325105/course-covers/000/001/814/1814-original.jpg?1609325105',
        'https://example.com/procreate_comics2.jpg',
      ],
      modules: [
        VideoModule(
          title: "Procreate bilan Tanishtirish",
          videoUrl: "https://www.example.com/video_procreate_intro.mp4",
          videos: [
            Video(videoTitle: "Procreate Interfeysi Tushunchasi", videoUrl: "https://www.example.com/video_procreate_intro1.mp4"),
            Video(videoTitle: "Procreate'da Chizish Asoslari", videoUrl: "https://www.example.com/video_procreate_intro2.mp4"),
            Video(videoTitle: "Komiks Panelarini Yaratish", videoUrl: "https://www.example.com/video_procreate_intro3.mp4"),
          ],
        ),
        VideoModule(
          title: "Komiksni Procreate'da Chizish",
          videoUrl: "https://www.example.com/video_procreate_sketching.mp4",
          videos: [
            Video(videoTitle: "Komiks Personajlari va Sahnalarini Chizish", videoUrl: "https://www.example.com/video_procreate_sketch1.mp4"),
            Video(videoTitle: "Komiks Dialoglarini Qo'shish", videoUrl: "https://www.example.com/video_procreate_sketch2.mp4"),
          ],
        ),
        VideoModule(
          title: "Procreate'da Rang Qo'shish va Effektlar",
          videoUrl: "https://www.example.com/video_procreate_color.mp4",
          videos: [
            Video(videoTitle: "Komiksni Ranglash uchun Brushlardan Foydalanish", videoUrl: "https://www.example.com/video_procreate_color1.mp4"),
            Video(videoTitle: "Procreate'da Qavatlar va Tekstura", videoUrl: "https://www.example.com/video_procreate_color2.mp4"),
          ],
        ),
        VideoModule(
          title: "Komiksni Procreate'da Yakunlash",
          videoUrl: "https://www.example.com/video_procreate_finalizing.mp4",
          videos: [
            Video(videoTitle: "Komiksni Eksport Qilish", videoUrl: "https://www.example.com/video_procreate_final1.mp4"),
            Video(videoTitle: "Raqamli Komiksni Noshirlik", videoUrl: "https://www.example.com/video_procreate_final2.mp4"),
          ],
        ),
      ],
    ),
    VideoCourse(
      name: "Manga Chizish: Yapon Komiks Stili",
      description: "Manga dunyosiga kirib, o'z manga komikslaringizni yaratishni o'rganing.",
      price: 89.99,
      imageUrls: [
        'https://cdn.domestika.org/c_fill,f_auto,pg_1,w_1000,dpr_1,ar_16:9/v1655456092/course-covers/000/004/171/4171-original.jpg?1655456092',
        'https://example.com/manga2.jpg',
      ],
      modules: [
        VideoModule(
          title: "Manga Chizishga Kirish",
          videoUrl: "https://www.example.com/video_manga_intro.mp4",
          videos: [
            Video(videoTitle: "Manga San'ati Stili", videoUrl: "https://www.example.com/video_manga_intro1.mp4"),
            Video(videoTitle: "Manga Personajlarini Yaratish", videoUrl: "https://www.example.com/video_manga_intro2.mp4"),
            Video(videoTitle: "Manga Yuz Xususiyatlarini Chizish", videoUrl: "https://www.example.com/video_manga_intro3.mp4"),
          ],
        ),
        VideoModule(
          title: "Manga Panelari va Layoutlari",
          videoUrl: "https://www.example.com/video_manga_paneling.mp4",
          videos: [
            Video(videoTitle: "Manga Layoutlarini Tushunish", videoUrl: "https://www.example.com/video_manga_panel1.mp4"),
            Video(videoTitle: "Dinamik Panel Tizimi", videoUrl: "https://www.example.com/video_manga_panel2.mp4"),
          ],
        ),
        VideoModule(
          title: "Manga Hikoyalarini Yaratish",
          videoUrl: "https://www.example.com/video_manga_story.mp4",
          videos: [
            Video(videoTitle: "Manga Ssenariysini Yozish", videoUrl: "https://www.example.com/video_manga_story1.mp4"),
            Video(videoTitle: "Manga Drama Qurish", videoUrl: "https://www.example.com/video_manga_story2.mp4"),
          ],
        ),
        VideoModule(
          title: "Manga Inking va So'laklar",
          videoUrl: "https://www.example.com/video_manga_inking.mp4",
          videos: [
            Video(videoTitle: "Manga Inking: Qalam va Siyoh", videoUrl: "https://www.example.com/video_manga_inking1.mp4"),
            Video(videoTitle: "Manga So'laklarini Yaratish", videoUrl: "https://www.example.com/video_manga_inking2.mp4"),
          ],
        ),
      ],
    ),
    // Boshqa Comics kurslarini qo'shish mumkin
  ];
}
