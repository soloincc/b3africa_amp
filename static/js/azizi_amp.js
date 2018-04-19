function AziziAMP() {
    $('#push2baobab').on('click', this.saveSamples2Baobab);
}

AziziAMP.prototype.saveSamples2Baobab = function(){
    if(dash.cur_form_id == undefined){
       swal({
          title: "Error!",
          text: "Please select at least one FORM to process.",
          imageUrl: "/static/img/error-icon.png"
        });
        return; 
    }
    $('#spinnermModal').modal('show');
    $.ajax({
        type: "POST", url: "/save_samples2baobab/", dataType: 'json', data: {'form_id': dash.cur_form_id},
        error: dash.communicationError,
        success: function (data) {
            $('#spinnermModal').modal('hide');
            // $('#saveRawDataEditsModal').modal('hide');
            if (data.error) {
                dash.showNotification('There was an error while pushing to baobab. Please contact the system administrator!', 'error', true);
            } else {
                dash.showNotification('The samples were saved in Baobab LIMS successfully!', 'success', true);
            }
        }
    });
};

var azizi_amp = new AziziAMP();
