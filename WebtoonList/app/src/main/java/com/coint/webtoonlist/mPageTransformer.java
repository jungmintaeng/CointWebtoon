package com.coint.webtoonlist;

import android.support.v4.view.ViewPager;
import android.view.View;

/**
 * Created by JWP on 2017-05-08.
 */

public class mPageTransformer implements ViewPager.PageTransformer{
    private static final float MIN_SCALE = 0.75f;

    @Override
    public void transformPage(View view, float position) {
        int pageWidth = view.getWidth();

        if (position < -1) { // [-Infinity,-1)
            // This page is way off-screen to the left.
            view.setAlpha(0);

        } else if (position <= 0) { // [-1,0]
            // Use the default slide transition when moving to the left page
            view.setAlpha(1);
            view.setTranslationX(0);
            view.setScaleX(1);
            view.setScaleY(1);

        } else if (position <= 1) { // (0,1]
            // Fade the page out.
            view.setAlpha(1);

            // Counteract the default slide transition
            view.setTranslationX(pageWidth * -position);


        } else { // (1,+Infinity]
            // This page is way off-screen to the right.
            view.setAlpha(0);
        }
    }
}