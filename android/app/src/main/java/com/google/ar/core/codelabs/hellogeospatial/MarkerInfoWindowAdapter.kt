// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package com.google.ar.core.codelabs.hellogeospatial

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.TextView
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.Marker
import com.google.ar.core.codelabs.hellogeospatial.place.Place

class MarkerInfoWindowAdapter(private val context: Context) : GoogleMap.InfoWindowAdapter {
    var latitude : Double=0.0
    var longtitude : Double=0.0
    var altitude : Double=0.0

    override fun getInfoContents(marker: Marker): View? {
        // 1. Get tag
        val place = marker.tag as? Place ?: return null

        // 2. Inflate view and set title, address and rating
        val view = LayoutInflater.from(context).inflate(R.layout.marker_info_contents, null)
        view.findViewById<TextView>(R.id.text_view_title).text = place.name
        view.findViewById<TextView>(R.id.text_view_address).text = place.address
        view.findViewById<TextView>(R.id.text_view_rating).text = "Rating: %.2f".format(place.rating)

        return view
    }

    fun getInfoplace(marker: Marker): String? {
        // 1. Get tag
        val place = marker.tag as? Place ?: return null

        return place.name
    }
    override fun getInfoWindow(marker: Marker): View? {
        // Return null to indicate that the default window (white bubble) should be used
        return null
    }
}