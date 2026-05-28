import 'dart:math';

class ImageHelper {
  static const List<String> _cafeImages = [
    "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1541167760496-1628856ab772?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1554118811-1e0d58224f24?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1481833761820-0509d3217039?auto=format&fit=crop&q=80&w=600",
  ];

  static const List<String> _hotelImages = [
    "https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1495365200479-c4ed1d35e1aa?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1621293954908-907159247fc8?auto=format&fit=crop&q=80&w=600",
  ];

  static const List<String> _heritageImages = [
    "https://images.unsplash.com/photo-1578469550956-0e16b69c6a3d?auto=format&fit=crop&q=80&w=600", // Prambanan/Temple style
    "https://images.unsplash.com/photo-1680143760509-eb94e83a6a4c?auto=format&fit=crop&q=80&w=600", // Borobudur
    "https://images.unsplash.com/photo-1711704595645-bc5216e4eeb9?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1636342684605-09cd79508ebe?auto=format&fit=crop&q=80&w=600",
  ];

  static const List<String> _wisataImages = [
    "https://images.unsplash.com/photo-1752583989286-1c774e2669f1?auto=format&fit=crop&q=80&w=600", // Bali/Indo landscape
    "https://images.unsplash.com/photo-1655861467672-215aaeb119ff?auto=format&fit=crop&q=80&w=600", // Mount Bromo
    "https://images.unsplash.com/photo-1694920607725-3a445dc0892a?auto=format&fit=crop&q=80&w=600", // Waterfall
    "https://images.unsplash.com/photo-1472213984618-c79aaec7fef0?auto=format&fit=crop&q=80&w=600",
  ];

  static const List<String> _tamanImages = [
    "https://images.unsplash.com/photo-1590509990541-edf999edee33?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1622050956578-94fd044a0ada?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1573004653136-a6be2574248d?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1615373111465-965023eb989c?auto=format&fit=crop&q=80&w=600",
  ];

  static const List<String> _umkmImages = [
    "https://images.unsplash.com/photo-1597129778410-0e4932adbd77?auto=format&fit=crop&q=80&w=600", // Market/Shopping
    "https://images.unsplash.com/photo-1643886024293-b5d3d6bf92b2?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1632762346768-80b093fc5f38?auto=format&fit=crop&q=80&w=600", // Craft
    "https://images.unsplash.com/photo-1666002237176-f1b96edd6242?auto=format&fit=crop&q=80&w=600",
  ];

  static const List<String> _generalImages = [
    "https://images.unsplash.com/photo-1586319826907-1ff4aadbaddc?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1442544213729-6a15f1611937?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1631002164896-004e2058d6e4?auto=format&fit=crop&q=80&w=600",
    "https://images.unsplash.com/photo-1630214801769-24784bfd2b9c?auto=format&fit=crop&q=80&w=600",
  ];

  /// Get a deterministic image URL based on the category and a string identifier (e.g. name or id)
  static String getImageForCategory(String? category, String identifier) {
    List<String> selectedList;

    switch (category?.toLowerCase()) {
      case 'cafe':
      case 'restoran':
        selectedList = _cafeImages;
        break;
      case 'hotel':
      case 'penginapan':
        selectedList = _hotelImages;
        break;
      case 'heritage':
      case 'museum':
      case 'sejarah':
        selectedList = _heritageImages;
        break;
      case 'wisata':
      case 'alam':
        selectedList = _wisataImages;
        break;
      case 'taman':
      case 'iconic':
        selectedList = _tamanImages;
        break;
      case 'umkm':
      case 'belanja':
      case 'oleh-oleh':
        selectedList = _umkmImages;
        break;
      default:
        selectedList = _generalImages;
    }

    // Use hash code to deterministically pick an index
    int index = (identifier.hashCode.abs()) % selectedList.length;
    return selectedList[index];
  }
}
