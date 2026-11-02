import 'package:flutter/material.dart';

import '../models/word.dart';
import '../models/word_set.dart';

/// Dữ liệu mẫu song ngữ. Mỗi lần gọi trả về bản mới.
/// Hãy bổ sung thêm từ cho mỗi bộ (mục tiêu 10-20 từ/bộ).
List<WordSet> buildSampleSets() {
  Word w(String id, String term, String phonetic, String vi, String en,
          String example) =>
      Word(
        id: id,
        term: term,
        phonetic: phonetic,
        meaningVi: vi,
        meaningEn: en,
        example: example,
      );

  return [
    WordSet(
      id: 'daily',
      nameVi: 'Giao tiếp hằng ngày',
      nameEn: 'Daily conversation',
      icon: Icons.chat_bubble_outline,
      color: const Color(0xFF2962C8),
      words: [
        w('d1', 'hello', '/həˈloʊ/', 'xin chào', 'a common greeting',
            'Hello, how are you?'),
        w('d2', 'thanks', '/θæŋks/', 'cảm ơn', 'a word to show gratitude',
            'Thanks for your help.'),
        w('d3', 'sorry', '/ˈsɑːri/', 'xin lỗi', 'used to apologize',
            'Sorry, I am late.'),
        w('d4', 'please', '/pliːz/', 'làm ơn', 'used to ask politely',
            'Please sit down.'),
        w('d5', 'welcome', '/ˈwelkəm/', 'chào mừng',
            'a friendly greeting to someone arriving', 'Welcome to our home.'),
        w('d6', 'goodbye', '/ˌɡʊdˈbaɪ/', 'tạm biệt', 'said when leaving',
            'Goodbye, see you tomorrow.'),
        w('d7', 'friend', '/frend/', 'bạn bè',
            'a person you like and know well', 'She is my best friend.'),
        w('d8', 'family', '/ˈfæməli/', 'gia đình',
            'parents, children and relatives', 'I love my family.'),
      ],
    ),
    WordSet(
      id: 'travel',
      nameVi: 'Du lịch',
      nameEn: 'Travel',
      icon: Icons.flight_outlined,
      color: const Color(0xFFFF8A3D),
      words: [
        w('t1', 'airport', '/ˈerpɔːrt/', 'sân bay',
            'a place where planes land and take off', 'We arrived at the airport.'),
        w('t2', 'ticket', '/ˈtɪkɪt/', 'vé',
            'a paper or card that lets you travel', 'I bought a train ticket.'),
        w('t3', 'luggage', '/ˈlʌɡɪdʒ/', 'hành lý',
            'bags and cases for a trip', 'My luggage is heavy.'),
        w('t4', 'hotel', '/hoʊˈtel/', 'khách sạn',
            'a place to stay for a night', 'The hotel is near the beach.'),
        w('t5', 'passport', '/ˈpæspɔːrt/', 'hộ chiếu',
            'an official travel document', 'Do not forget your passport.'),
        w('t6', 'map', '/mæp/', 'bản đồ', 'a drawing of an area',
            'Can you show me on the map?'),
      ],
    ),
    WordSet(
      id: 'work',
      nameVi: 'Công việc',
      nameEn: 'Work',
      icon: Icons.work_outline,
      color: const Color(0xFF2E9E6B),
      words: [
        w('w1', 'meeting', '/ˈmiːtɪŋ/', 'cuộc họp',
            'an event where people discuss things', 'The meeting starts at nine.'),
        w('w2', 'deadline', '/ˈdedlaɪn/', 'hạn chót',
            'the latest time to finish something', 'The deadline is Friday.'),
        w('w3', 'manager', '/ˈmænɪdʒər/', 'quản lý',
            'a person who leads a team', 'My manager is friendly.'),
        w('w4', 'report', '/rɪˈpɔːrt/', 'báo cáo',
            'a document with information', 'I wrote a short report.'),
        w('w5', 'salary', '/ˈsæləri/', 'lương',
            'money you get for your job', 'He earns a good salary.'),
        w('w6', 'colleague', '/ˈkɑːliːɡ/', 'đồng nghiệp',
            'a person you work with', 'My colleague helped me.'),
      ],
    ),
    WordSet(
      id: 'academic',
      nameVi: 'Học thuật',
      nameEn: 'Academic',
      icon: Icons.menu_book_outlined,
      color: const Color(0xFF7C5CD6),
      words: [
        w('a1', 'research', '/ˈriːsɜːrtʃ/', 'nghiên cứu',
            'careful study to find facts', 'She does research on climate.'),
        w('a2', 'analyze', '/ˈænəlaɪz/', 'phân tích',
            'to study something in detail', 'We analyze the data.'),
        w('a3', 'thesis', '/ˈθiːsɪs/', 'luận văn',
            'a long piece of academic writing', 'He is writing his thesis.'),
        w('a4', 'evidence', '/ˈevɪdəns/', 'bằng chứng',
            'facts that show something is true', 'There is no evidence.'),
        w('a5', 'theory', '/ˈθɪri/', 'lý thuyết',
            'an idea that explains something', 'This theory is popular.'),
        w('a6', 'method', '/ˈmeθəd/', 'phương pháp',
            'a way of doing something', 'This method is simple.'),
      ],
    ),
  ];
}