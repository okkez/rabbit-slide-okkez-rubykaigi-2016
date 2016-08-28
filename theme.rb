include_theme("rurema")

@lightning_talk_proc_name = "lightning-rurema"
@lightning_talk_as_large_as_possible = true
include_theme("lightning-talk-toolkit")

match(TitleSlide, Title) do |titles|
  prop_set("weight", "normal")
end

match(Slide) do |slides|
  slides.each do |slide|
    if slide.lightning_talk?
      slide.lightning_talk
    end
  end
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
