# review-ext.rb
# //articlecard[タグ][@著者ID]{                     ← タイトル自動・番号自動
# //articlecard[タグ][番号][@著者ID]{               ← タイトル自動・番号指定
# //articlecard[タイトル][タグ][番号][@著者ID]{     ← タイトル指定・番号指定
# タイトルは省略時に章名(=)から自動取得。番号は省略時に章番号を自動採番。

ReVIEW::Compiler.defblock :articlecard, 2..4

class ReVIEW::LATEXBuilder
  def articlecard(lines, *args)
    case args.size
    when 4
      title, tags, number, author = args
      title = compile_inline(title)
    when 3
      tags, number, author = args
      title = compile_inline(@chapter.title)
    when 2
      tags, author = args
      title = compile_inline(@chapter.title)
      number = @chapter.number.to_s
    end
    puts "\\articlecard{#{title}}{#{escape(tags)}}{#{escape(number)}}{#{escape(author)}}"
  end
end
