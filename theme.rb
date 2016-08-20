include_theme("rurema")

match(TitleSlide, Title) do |titles|
  prop_set("weight", "normal")
end

match(Slide, HeadLine) do |head_lines|
  prop_set("weight", "normal")
end

match("**", Emphasis) do |emphases|
  prop_set("weight", "normal")
end

match("**", ReferText) do |texts|
  texts.prop_set("underline", "none")
  texts.prop_set("foreground", "darkblue")
end

match("**", DescriptionTerm) do |terms|
  terms.prop_set("weight", "normal")
end
