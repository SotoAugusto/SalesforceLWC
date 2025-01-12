public class PokeApiResponse2{
		public Integer order{get;set;}
		public list<moves> moves{get;set;}
		public String name{get;set;}
		public String location_area_encounters{get;set;}
		public list<String> past_abilities{get;set;}
		public Boolean is_default{get;set;}
		public list<String> past_types{get;set;}
		public Integer id{get;set;}
		public species species{get;set;}
		public list<held_items> held_items{get;set;}
		public Integer height{get;set;}
		public list<game_indices> game_indices{get;set;}
		public sprites sprites{get;set;}
		public list<forms> forms{get;set;}
		public list<stats> stats{get;set;}
		public cries cries{get;set;}
		public list<types> types{get;set;}
		public Integer base_experience{get;set;}
		public Integer weight{get;set;}
		public list<abilities> abilities{get;set;}
	public class yellow{
		public String front_transparent{get;set;}
		public String front_gray{get;set;}
		public String back_transparent{get;set;}
		public String back_gray{get;set;}
		public String front_default{get;set;}
		public String back_default{get;set;}
	}
	public class xy{
		public String front_default{get;set;}
		public String front_shiny{get;set;}
		public String front_shiny_female{get;set;}
		public String front_female{get;set;}
	}
	public class versions{
		public generationi generationi{get;set;}
		public generationvi generationvi{get;set;}
		public generationiii generationiii{get;set;}
		public generationiv generationiv{get;set;}
		public generationii generationii{get;set;}
		public generationv generationv{get;set;}
		public generationviii generationviii{get;set;}
		public generationvii generationvii{get;set;}
	}
	public class version_group_details{
		public version_group version_group{get;set;}
		public move_learn_method move_learn_method{get;set;}
		public Integer level_learned_at{get;set;}
	}
	public class version_group{
		public String name{get;set;}
		public String url{get;set;}
	}
	public class version_details{
		public version version{get;set;}
		public Integer rarity{get;set;}
	}
	public class version{
		public String name{get;set;}
		public String url{get;set;}
	}
	public class ultrasunultramoon{
		public String front_default{get;set;}
		public String front_shiny{get;set;}
		public String front_shiny_female{get;set;}
		public String front_female{get;set;}
	}
	public class types{
		public Integer slot{get;set;}
		public type type{get;set;}
	}
	public class type{
		public String url{get;set;}
		public String name{get;set;}
	}
	public class stats{
		public stat stat{get;set;}
		public Integer effort{get;set;}
		public Integer base_stat{get;set;}
	}
	public class stat{
		public String url{get;set;}
		public String name{get;set;}
	}
	public class sprites{
		public other other{get;set;}
		public String back_shiny_female{get;set;}
		public String front_default{get;set;}
		public String back_shiny{get;set;}
		public String front_female{get;set;}
		public String back_female{get;set;}
		public String front_shiny{get;set;}
		public String back_default{get;set;}
		public String front_shiny_female{get;set;}
		public versions versions{get;set;}
	}
	public class species{
		public String url{get;set;}
		public String name{get;set;}
	}
	public class silver{
		public String back_default{get;set;}
		public String back_shiny{get;set;}
		public String front_shiny{get;set;}
		public String front_transparent{get;set;}
		public String front_default{get;set;}
	}
	public class showdown{
		public String front_shiny_female{get;set;}
		public String front_female{get;set;}
		public String front_shiny{get;set;}
		public String front_default{get;set;}
		public String back_shiny{get;set;}
		public String back_female{get;set;}
		public String back_shiny_female{get;set;}
		public String back_default{get;set;}
	}
	public class rubysapphire{
		public String back_default{get;set;}
		public String front_default{get;set;}
		public String front_shiny{get;set;}
		public String back_shiny{get;set;}
	}
	public class redblue{
		public String front_gray{get;set;}
		public String back_transparent{get;set;}
		public String front_default{get;set;}
		public String back_gray{get;set;}
		public String front_transparent{get;set;}
		public String back_default{get;set;}
	}
	public class platinum{
		public String back_female{get;set;}
		public String front_default{get;set;}
		public String front_female{get;set;}
		public String back_shiny_female{get;set;}
		public String front_shiny{get;set;}
		public String back_shiny{get;set;}
		public String front_shiny_female{get;set;}
		public String back_default{get;set;}
	}
	public class other{
		public officialartwork officialartwork{get;set;}
		public home home{get;set;}
		public showdown showdown{get;set;}
		public dream_world dream_world{get;set;}
	}
	public class omegarubyalphasapphire{
		public String front_female{get;set;}
		public String front_shiny{get;set;}
		public String front_shiny_female{get;set;}
		public String front_default{get;set;}
	}
	public class officialartwork{
		public String front_default{get;set;}
		public String front_shiny{get;set;}
	}
	public class moves{
		public list<version_group_details> version_group_details{get;set;}
		public move move{get;set;}
	}
	public class move_learn_method{
		public String name{get;set;}
		public String url{get;set;}
	}
	public class move{
		public String url{get;set;}
		public String name{get;set;}
	}
	public class item{
		public String name{get;set;}
		public String url{get;set;}
	}
	public class icons{
		public String front_default{get;set;}
		public String front_female{get;set;}
	}
	public class home{
		public String front_default{get;set;}
		public String front_female{get;set;}
		public String front_shiny{get;set;}
		public String front_shiny_female{get;set;}
	}
	public class held_items{
		public list<version_details> version_details{get;set;}
		public item item{get;set;}
	}
	public class heartgoldsoulsilver{
		public String back_female{get;set;}
		public String front_default{get;set;}
		public String front_female{get;set;}
		public String back_shiny_female{get;set;}
		public String front_shiny{get;set;}
		public String back_shiny{get;set;}
		public String front_shiny_female{get;set;}
		public String back_default{get;set;}
	}
	public class gold{
		public String front_transparent{get;set;}
		public String front_shiny{get;set;}
		public String front_default{get;set;}
		public String back_shiny{get;set;}
		public String back_default{get;set;}
	}
	public class generationviii{
		public icons icons{get;set;}
	}
	public class generationvii{
		public icons icons{get;set;}
		public ultrasunultramoon ultrasunultramoon{get;set;}
	}
	public class generationvi{
		public omegarubyalphasapphire omegarubyalphasapphire{get;set;}
		public xy xy{get;set;}
	}
	public class generationv{
		public blackwhite blackwhite{get;set;}
	}
	public class generationiv{
		public heartgoldsoulsilver heartgoldsoulsilver{get;set;}
		public platinum platinum{get;set;}
		public diamondpearl diamondpearl{get;set;}
	}
	public class generationiii{
		public rubysapphire rubysapphire{get;set;}
		public fireredleafgreen fireredleafgreen{get;set;}
		public emerald emerald{get;set;}
	}
	public class generationii{
		public silver silver{get;set;}
		public gold gold{get;set;}
		public crystal crystal{get;set;}
	}
	public class generationi{
		public redblue redblue{get;set;}
		public yellow yellow{get;set;}
	}
	public class game_indices{
		public Integer game_index{get;set;}
		public version version{get;set;}
	}
	public class forms{
		public String url{get;set;}
		public String name{get;set;}
	}
	public class fireredleafgreen{
		public String front_shiny{get;set;}
		public String back_shiny{get;set;}
		public String front_default{get;set;}
		public String back_default{get;set;}
	}
	public class emerald{
		public String front_shiny{get;set;}
		public String front_default{get;set;}
	}
	public class dream_world{
		public String front_female{get;set;}
		public String front_default{get;set;}
	}
	public class diamondpearl{
		public String back_female{get;set;}
		public String front_female{get;set;}
		public String front_shiny{get;set;}
		public String front_default{get;set;}
		public String front_shiny_female{get;set;}
		public String back_shiny_female{get;set;}
		public String back_default{get;set;}
		public String back_shiny{get;set;}
	}
	public class crystal{
		public String front_transparent{get;set;}
		public String back_shiny_transparent{get;set;}
		public String back_transparent{get;set;}
		public String back_shiny{get;set;}
		public String front_default{get;set;}
		public String back_default{get;set;}
		public String front_shiny{get;set;}
		public String front_shiny_transparent{get;set;}
	}
	public class cries{
		public String legacy{get;set;}
		public String latest{get;set;}
	}
	public class blackwhite{
		public animated animated{get;set;}
		public String front_default{get;set;}
		public String back_shiny_female{get;set;}
		public String front_female{get;set;}
		public String back_shiny{get;set;}
		public String front_shiny{get;set;}
		public String back_female{get;set;}
		public String front_shiny_female{get;set;}
		public String back_default{get;set;}
	}
	public class animated{
		public String back_default{get;set;}
		public String back_shiny{get;set;}
		public String back_female{get;set;}
		public String back_shiny_female{get;set;}
		public String front_female{get;set;}
		public String front_default{get;set;}
		public String front_shiny{get;set;}
		public String front_shiny_female{get;set;}
	}
	public class ability{
		public String url{get;set;}
		public String name{get;set;}
	}
	public class abilities{
		public Integer slot{get;set;}
		public Boolean is_hidden{get;set;}
		public ability ability{get;set;}
	}
}