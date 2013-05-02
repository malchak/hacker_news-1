// Some general UI pack related JS

$(document).ready(function() {

    $("#comment_form").on('submit', function(event){
        event.preventDefault();
        $.ajax({
            type: "POST",
            url: '/new_comment',
            data: {
                user_id: $('#user_id').val(), 
                post_id: $('#post_id').val(), 
                content: $('#content').val()
            }
        })
        .done(function(){
            $("")
        })
    });

    // Make pagination demo work
    // $(".pagination a").click(function() {
    //     if (!$(this).parent().hasClass("previous") && !$(this).parent().hasClass("next")) {
    //         $(this).parent().siblings("li").removeClass("active");
    //         $(this).parent().addClass("active");
    //     }
    // });

    // $(".btn-group a").click(function() {
    //     $(this).siblings().removeClass("active");
    //     $(this).addClass("active");
    // });

    // // Disable link click not scroll top
    // $("a[href='#']").click(function() {
    //     return false
    // });

});

