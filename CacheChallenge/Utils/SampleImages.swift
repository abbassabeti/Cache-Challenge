//
//  SampleImages.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import Foundation

final class SampleImages {
    static let items: [String] = [
        "https://cdn.prod.website-files.com/63a02e61e7ffb565c30bcfc7/65ea95887efa5c72ece1abb0_most%20beautiful%20landscapes%20in%20the%20world-p-2000.webp",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-1-mountains.ashx?la=en-nz",
        "https://www.hdwallpapers.in/download/red_dodge_hornet_rt_fc1_x_2024_car_4k_hd_cars-HD.jpg",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-2-snow-mountains.ashx?la=en-nz&h=1250&w=1000&hash=CD0F5572F7DADD92EAFF7D2AEEA8E60A",
        "https://www.hdwallpapers.in/download/yellow_porsche_911_gt3_rs_weissach_package_car_4k_5k_hd_cars-HD.jpg",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-3-forest-fog.ashx?la=en-nz",
        "https://www.hdwallpapers.in/download/closeup_view_path_meadow_field_hills_sunrise_wallpaper_clouds_sky_background_4k_hd_nature-HD.jpg",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-4-reflections-mountains.ashx?la=en-nz",
        "https://www.hdwallpapers.in/download/waterfalls_from_rocks_green_trees_dry_grass_hd_nature-HD.jpg",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-6-flowers-ocean.ashx?la=en-nz",
        "https://www.hdwallpapers.in/download/waterfalls_on_rocks_stream_green_trees_bushes_plants_forest_background_hd_nature-HD.jpg",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-10-head-matakana.ashx?la=en-nz",
        "https://www.hdwallpapers.in/thumbs/2021/a_boy_is_sleeping_on_horse_hd_horse-t2.jpg",
        "https://www.hdwallpapers.in/download/waterfalls_stream_between_green_trees_bushes_plants_during_daytime_4k_hd_nature-HD.jpg",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-11-tauranga.ashx?la=en-nz",
        "https://www.hdwallpapers.in/download/colorful_diwali_with_crackers_hd_diwali-HD.jpg",
        "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-13-reflections-lak.ashx?la=en-nz",
        "https://www.hdwallpapers.in/download/white_2025_lincoln_navigator_l_black_label_car_4k_5k_hs_cars-HD.jpg",
        "https://www.hdwallpapers.in/download/green_lamborghini_temerario_alleggerita_2024_car_4k_5k_hd_cars-HD.jpg",
        "https://learn.zoner.com/wp-content/uploads/2018/08/landscape-photography-at-every-hour-part-ii-photographing-landscapes-in-rain-or-shine.jpg",
        "https://learn.zoner.com/wp-content/uploads/2018/08/pano_light_clouds-683x219.jpg",
        "https://learn.zoner.com/wp-content/uploads/2018/08/cloudy_out_of_camera-683x456.jpg",
        "https://www.hdwallpapers.in/thumbs/2024/brown_orange_white_lines_butterfly_on_green_grass_in_dark_background_4k_hd_butterfly-t2.jpg",
        "https://www.hdwallpapers.in/thumbs/2024/yellow_black_blue_dots_lines_closeup_view_butterfly_on_green_leaves_4k_hd_butterfly-t2.jpg",
        "https://www.hdwallpapers.in/thumbs/2020/cute_red_pink_and_white_bird_is_perching_on_snow_covered_tree_branch_in_white_background_hd_animals-t2.jpg",
        "https://www.hdwallpapers.in/thumbs/2020/cute_brown_and_white_bird_is_sitting_on_snow_in_blur_white_background_hd_animals-t2.jpg",
    ]

    class func provideTips() -> [ImageTip] {
        return items.compactMap { rawUrl in
            guard let url = URL(string: rawUrl) else { return nil }
            return ImageTip(url: url)
        }
    }
}
