enum CompletionStatus(final String code, final String label) {
  all("","All works"),
  complete("T","Complete works only"),
  inProgress("F","Works in progress only");
}



enum Crossovers(final String code, final String label) {
  include("","Include crossovers"),
  exclude("T","Exclude crossovers"),
  only("F","Only crossovers");
}



enum BookmarkTypes(final String code, final String label) {
  any("","Any"),
  work("Work","Work"),
  Series("Series","Series"),
  externalWork("External Work","External Work");
}



enum TagTypes(final String code, final String label) {
  fandom("Fandom","Fandom"),
  character("Character","Character"),
  relationship("Relationship","Relationship"),
  freeform("Freeform","Freeform"),
  any("","Any type");
}



enum TagWrangling(final String code, final String label) {
  canonical("canonical","Canonical"),
  nonCanonical("noncanonical","Non-canonical"),
  synonymous("synonymous","Synonymous"),
  canonicalSynonymous("canonical_synonymous","Canonical or synonymous"),
  nonCanonicalNonSynonymous("noncanonical_nonsynonymous","Non-canonical and non-synonymous"),
  nonCanonicalNonSynonymousNotUnwrangleable("noncanonical_nonsynonymous_not_unwrangleable","Non-canonical and non-synonymous and not marked unwrangleable"),
  unwrangleable("unwrangleable","Unwrangleable"),
  any("","Any status");
}



enum SortColumnWork(final String code, final String label) {
  bestMatch("_score","Best Match"),
  author("authors_to_sort_on","Author"),
  title("title_to_sort_on","Title"),
  datePosted("created_at","Date Posted"),
  dateUpdated("revised_at","Date Updated"),
  wordCount("word_count","Word Count"),
  hits("hits","Hits"),
  kudos("kudos_count","Kudos"),
  comments("comments_count","Comments"),
  bookmarks("bookmarks_count","Bookmarks");
}



enum SortColumnTags(final String code, final String label) {
  name("name","Name"),
  dateCreated("created_at","Date Created"),
  uses("uses","Uses");
}



enum SortByBookmark(final String code, final String label) {
  bestMatch("","Best Match"),
  dateBookmarked("created_at","Date Bookmarked"),
  dateUpdated("bookmarkable_date","Date Updated"),
  wordCount("word_count","Word Count");
}



enum SortDirection(final String code, final String label) {
  asc("asc","Ascending"),
  desc("desc","Descending");
}



enum LanguageOptions(final String code, final String label) {
  any("", "Any"),

  so("so", "af Soomaali"),
  afr("afr", "Afrikaans"),
  ain("ain", "Aynu itak | アイヌ イタㇰ"),
  akk("akk", "𒀝𒅗𒁺𒌑"),
  ar("ar", "العربية"),
  amh("amh", "አማርኛ"),
  egy("egy", "𓂋𓏺𓈖 𓆎𓅓𓏏𓊖"),
  oji("oji", "Anishinaabemowin"),
  arc("arc", "ܐܪܡܝܐ | ארמיא"),
  hy("hy", "հայերեն"),

  ase("ase", "American Sign Language"),
  ast("ast", "asturianu"),
  azj("azj", "Azərbaycan dili | آذربایجان دیلی"),
  id("id", "Bahasa Indonesia"),
  ms("ms", "Bahasa Malaysia"),
  bg("bg", "Български"),
  bn("bn", "বাংলা"),
  jv("jv", "Basa Jawa"),
  sun("sun", "ᮘᮞ ᮞᮥᮔ᮪ᮓ | Basa Sunda"),
  ba("ba", "Башҡорт теле"),

  be("be", "беларуская"),
  bar("bar", "Boarisch"),
  bos("bos", "Bosanski"),
  br("br", "Brezhoneg"),
  bfi("bfi", "British Sign Language"),
  bua("bua", "Буряад хэлэн | ᠪᠤᠷᠢᠶᠠᠳ ᠮᠣᠩᠭᠣᠯ ᠬᠡᠯᠡ"),
  ca("ca", "Català"),
  ceb("ceb", "Cebuano"),
  cs("cs", "Čeština"),
  chn("chn", "Chinuk Wawa"),

  crh("crh", "къырымтатар тили | qırımtatar tili"),
  cy("cy", "Cymraeg"),
  da("da", "Dansk"),
  de("de", "Deutsch"),
  div("div", "ދިވެހި,"),
  et("et", "eesti keel"),
  el("el", "Ελληνικά"),
  sux("sux", "𒅴𒂠"),
  en("en", "English"),
  ang("ang", "Eald Englisċ"),

  es("es", "Español"),
  eo("eo", "Esperanto"),
  eu("eu", "Euskara"),
  fa("fa", "فارسی"),
  fil("fil", "Filipino"),
  cha("cha", "Finuʼ Chamorro"),
  fr("fr", "Français"),
  frr("frr", "Friisk"),
  fry("fry", "Frysk"),
  fur("fur", "Furlan"),

  ga("ga", "Gaeilge"),
  gd("gd", "Gàidhlig"),
  gl("gl", "Galego"),
  got("got", "𐌲𐌿𐍄𐌹𐍃𐌺𐌰"),
  gyn("gyn", "Creolese"),
  hak("hak", "中文-客家话"),
  ko("ko", "한국어"),
  hau("hau", "Hausa | هَرْشَن هَوْسَ"),
  hi("hi", "हिन्दी"),
  mww("mww", "Hmoob dawb"),

  hr("hr", "Hrvatski"),
  haw("haw", "ʻŌlelo Hawaiʻi"),
  ia("ia", "Interlingua"),
  zu("zu", "isiZulu"),
  isl("is", "Íslenska"),
  it("it", "Italiano"),
  he("he", "עברית"),
  kal("kal", "Kalaallisut"),
  xal("xal", "Хальмг Өөрдин келн"),
  moh("moh", "Kanienʼkéha"),

  kan("kan", "ಕನ್ನಡ"),
  kat("kat", "ქართული"),
  cor("cor", "Kernewek"),
  khm("khm", "ភាសាខ្មែរ"),
  qkz("qkz", "Khuzdul"),
  sw("sw", "Kiswahili"),
  ht("ht", "kreyòl ayisyen"),
  ku("ku", "Kurdî | کوردی"),
  kir("kir", "Кыргызча"),
  lad("lad", "Ladino / לאדינו"),

  fcs("fcs", "Langue des signes québécoise"),
  lv("lv", "Latviešu valoda"),
  lb("lb", "Lëtzebuergesch"),
  lt("lt", "Lietuvių kalba"),
  la("la", "Lingua latina"),
  hu("hu", "Magyar"),
  mk("mk", "македонски"),
  ml("ml", "മലയാളം"),
  mt("mt", "Malti"),
  mnc("mnc", "ᠮᠠᠨᠵᡠ ᡤᡳᠰᡠᠨ"),

  qmd("qmd", "Mando'a"),
  mr("mr", "मराठी"),
  mic("mic", "Mi'kmaq"),
  enm("enm", "Middel Englisch"),
  mik("mik", "Mikisúkî"),
  hnj("hnj", "Moob leeg"),
  mon("mon", "ᠮᠣᠩᠭᠣᠯ ᠪᠢᠴᠢᠭ᠌ | Монгол Кирилл үсэг"),
  my("my", "မြန်မာဘာသာ"),
  myv("myv", "Эрзянь кель"),
  qnv("qnv", "Lìʼfya leNaʼvi"),

  nah("nah", "Nāhuatl"),
  nan("nan", "中文-闽南话 臺語"),
  ppl("ppl", "Nawat"),
  nl("nl", "Nederlands"),
  ja("ja", "日本語"),
  no("no", "Norsk"),
  ce("ce", "Нохчийн мотт"),
  ood("ood", "O’odham Ñiok"),
  ota("ota", "لسان عثمانى"),
  ps("ps", "پښتو"),

  pdc("pdc", "Pennsilfaanisch Deitsch"),
  nds("nds", "Plattdüütsch"),
  pl("pl", "Polski"),
  ptBR("ptBR", "Português brasileiro"),
  ptPT("ptPT", "Português europeu"),
  fuc("fuc", "Pulaar"),
  pa("pa", "ਪੰਜਾਬੀ"),
  kaz("kaz", "qazaqşa | қазақша"),
  qlq("qlq", "Uncategorized Constructed Languages"),
  qya("qya", "Quenya"),

  ro("ro", "Română"),
  rom("rom", "RRomani Ćhib"),
  ru("ru", "Русский"),
  smi("smi", "Sámi"),
  sah("sah", "саха тыла"),
  sco("sco", "Scots"),
  sq("sq", "Shqip"),
  sjn("sjn", "Sindarin"),
  si("si", "සිංහල"),
  sk("sk", "Slovenčina"),

  slv("slv", "Slovenščina"),
  sla("sla", "Slověnьskъ Językъ"),
  gem("gem", "Sprēkō Þiudiskō"),
  sr("sr", "Српски"),
  fi("fi", "suomi"),
  sv("sv", "Svenska"),
  ta("ta", "தமிழ்"),
  tat("tat", "татар теле"),
  mri("mri", "te reo Māori"),
  tel("tel", "తెలుగు"),

  tir("tir", "ትግርኛ"),
  th("th", "ไทย"),
  tqx("tqx", "Thermian"),
  bod("bod", "བོད་སྐད་"),
  vi("vi", "Tiếng Việt"),
  cop("cop", "ϯⲙⲉⲧⲣⲉⲙⲛ̀ⲭⲏⲙⲓ"),
  tlh("tlh", "tlhIngan-Hol"),
  tok("tok", "toki pona"),
  trf("trf", "Trinidadian Creole"),
  tsd("tsd", "τσακώνικα"),

  chr("chr", "ᏣᎳᎩ ᎦᏬᏂᎯᏍᏗ"),
  tr("tr", "Türkçe"),
  uk("uk", "Українська"),
  ale("ale", "Unangam Tunuu"),
  urd("urd", "اُردُو"),
  uig("uig", "ئۇيغۇر تىلى"),
  vol("vol", "Volapük"),
  wuu("wuu", "中文-吴语"),
  yi("yi", "יידיש"),
  yua("yua", "maayaʼ tʼàan"),

  yue("yue", "中文-广东话 粵語"),
  zh("zh", "中文-普通话 國語");
}